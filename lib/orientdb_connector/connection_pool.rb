require 'thread'
require 'monitor'



module OrientDBConnector

  class TimeoutError < StandardError; end

  class ConnectionPool

    DEFAULT_OPTIONS = { max_size: 5, timeout: 1 }

    def initialize(options = {})
      options = DEFAULT_OPTIONS.merge(options)
      @max_size = options[:max_size]
      @timeout = options[:timeout]

      @mutex = Mutex.new
      @mutex_condition = ConditionVariable.new

      @available = []
      @currently_used = {}

    end

    def with_connection
      conn = nil
      @mutex.synchronize do
        expiration_time = Time.now + @timeout
        begin
          conn = @available.pop

          if conn
            @currently_used[conn.object_id] = conn
          elsif current_queue_length < @max_size
            conn = create_new_connection()
            @currently_used[conn.object_id] = conn
          else
            # release the lock and wait for a wakeup signal ( return after max 0.5 second )
            @mutex_condition.wait(@mutex, 0.5)
          end

          raise TimeoutError, "Couldn't acquire connection for #{@timeout} sec. "  if expiration_time <= Time.now

        end while conn.nil?
      end

      yield conn

    ensure
      release_connection conn
    end

    def release_connection(conn)
      @mutex.synchronize do
        unless conn.nil?
          @currently_used.delete(conn.object_id)
          @available << conn
        end
        @mutex_condition.broadcast
      end
    end

    def current_queue_length
      @currently_used.length + @available.length
    end

    def create_new_connection
      ::OrientDBConnector::Connection.new()
    end

  end
end
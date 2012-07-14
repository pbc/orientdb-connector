require 'thread'

module OrientDBConnector

  class ConnectionPool

    DEFAULT_OPTIONS = { size: 5 }

    def initialize(options = {})

      options = DEFAULT_OPTIONS.merge(options)

      @size = options[:size]
      @wait_time = options[:size]

      @available = []
      @used = {}

      @mutex = Mutex.new
      @condition = ConditionVariable.new
    end

    def aquire()
      conn = nil
      @mutex.synchronize do

        begin

          conn = @available.pop

          if conn
            @used << conn
            yield conn
          elsif current_queue_length < @size
            conn = create_new_connection
            @used[conn.object_id] << conn
          else
            # release the lock and wait for a wakeup signal ( return after max 0.5 second )
            @condition.wait(@mutex, 0.5)
          end

        end while conn.nil?

        yield conn

      end
    ensure
      release conn
    end

    def current_queue_length
      @used.length + @available.length
    end

    def release(conn)
      return if conn.nil?
      @mutex.synchronize do

        @available << @used[conn.object_id]
        @condition.broadcast

      end
    end

    def create_new_connection
      ::OrientDBConnector::Connection.new()
    end



  end
end
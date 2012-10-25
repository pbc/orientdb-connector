module OrientDBConnector
  class SimpleClient

    attr_reader :connection_pool
    attr_reader :last_raw_response

    def initialize(custom_connection_params = nil)
      @connection_params = custom_connection_params
      @connection_pool = ::OrientDBConnector::ConnectionPool.new(connection_params: connection_params)
    end

    def connection_params
      @connection_params ||= ::OrientDBConnector::Base.config.connection_params
    end

    def use_connection(&block)
      connection_pool.with_connection do |conn|
        block.call(conn)
      end
      self
    end

    # if soft == true then we close only the connections which are not being used by other threads
    def close_all_connections(soft=true)
      connection_pool.close(soft)
    end

    def send_request(command, request_object)
      response = nil
      use_connection do |conn|
        conn.send_raw_request(request_object.to_binary_s)
        @last_raw_response = conn.get_raw_response
        response = create_response(command, @last_raw_response)
      end
      response
    end

    def create_response_object(type)
      ::OrientDBConnector::Protocol::Commands::ResponseFactory.create(type)
    end

    def create_request_object(type)
      ::OrientDBConnector::Protocol::Commands::RequestFactory.create(type)
    end

    private

      def create_response(command, raw_response)
        if raw_response.nil?
          create_response_object(command).read(raw_response)
        elsif raw_response.getbyte(0).to_i == 1
          create_response_object(:error).read(raw_response)
        else
          create_response_object(command).read(raw_response)
        end
      end

  end
end
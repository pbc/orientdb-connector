module OrientDBConnector
  class Client

    attr_reader :connection_pool

    def initialize
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



    def close_connection
      connection_pool.close
    end

  end
end
module OrientDBConnector
  class Client

    attr_reader :connection

    def connection_params
      @connection_params ||= ::OrientDBConnector::Base.config.connection_params
    end

    def open_connection
      @connection = ::OrientDBConnector::Connection.new(connection_params) if !@connection
      self
    end

    def close_connection
      @connection.close if !@connection.nil?
    end

  end
end
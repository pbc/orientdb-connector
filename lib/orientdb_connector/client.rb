module OrientDBConnector
  class Client

    attr_reader :client

    def initialize(conn_params = nil)
      @client = ::OrientDBConnector::SimpleClient.new(conn_params)
    end



  end
end
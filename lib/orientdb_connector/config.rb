module OrientDBConnector
  class Config

    def self.instance
      @instance ||= new
    end

    def connection_params
      @connection_params ||= {}
    end

  end
end
module OrientDBConnector
  class Config

    def self.instance
      @instance ||= new
    end

    def connection_params
      @connection_params ||= {}
    end

    def connection_params=(value)
      if value.is_a?(Hash)
        @connection_params = value
      else
        raise StandardError.new("connection_params needs to be a Hash")
      end
    end

  end
end
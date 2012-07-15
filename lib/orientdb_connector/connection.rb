module OrientDBConnector

  class Connection

    def initialize(options = nil)
      options = OrientDBConnector::Base.config.connection_params if options.nil?
      @host = options[:host]
      @port = options[:port]
      #@user = options[:user]
      #@password = options[:password]
    end





  end

end
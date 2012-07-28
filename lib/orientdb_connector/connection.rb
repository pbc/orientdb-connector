require "socket"

module OrientDBConnector

  class Connection

    attr_accessor :socket

    def initialize(options = {})
      @host = options[:host]
      @port = options[:port]
      @socket = open_socket(options[:socket_type])
      #@user = options[:user]
      #@password = options[:password]
    end

    def send_raw_request(request)
      socket.write(request)
    end

    def get_raw_response
      socket.gets
    end

    def close
      socket.close
    end

    def open_socket(socket_type = :tcp)
      socket_type = socket_type.to_sym
      if socket_type == :tcp
        OrientDBConnector::Utils::TCPSocket.new(host,port)
      end
    end

    def host
      @host
    end

    def port
      @port
    end

  end

end
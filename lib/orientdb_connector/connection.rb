require "socket"

module OrientDBConnector

  class Connection

    attr_reader :socket
    attr_reader :protocol_version

    def initialize(options = {})
      @host = options[:host]
      @port = options[:port]
      @socket = open_socket(options[:socket_type])

      # we need to read 2 byte protocol ID right after establishing new connection
      @protocol_version = BinData::Int16be.read(self.get_raw_response)
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
      else
        raise StandardError.new("provided socket type is not supported")
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
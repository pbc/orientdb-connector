require "socket"

module OrientDBConnector

  class Connection

    attr_reader :host
    attr_reader :port
    attr_reader :socket
    attr_reader :socket_operation_timeout
    attr_reader :protocol_version

    def initialize(options = {})
      @host = options[:host]
      @port = options[:port]
      @socket_operation_timeout = options[:socket_operation_timeout] || 0.5

      @socket = open_socket(options[:socket_type])

      # we have to read 2 byte protocol ID right after establishing new connection
      @protocol_version = BinData::Int16be.read(self.get_raw_response)
    end

    def send_raw_request(request)
      socket.write(request)
    end

    def get_raw_response
      socket.read
    end

    def close
      socket.close
    end

    def open_socket(socket_type = :tcp)
      socket_type = socket_type.to_sym
      if socket_type == :tcp
        OrientDBConnector::Utils::TCPSocket.new(host, port, socket_operation_timeout)
      else
        raise StandardError.new("provided socket type is not supported")
      end
    end

  end

end
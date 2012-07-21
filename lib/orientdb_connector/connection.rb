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
      socket.puts(request)
    end

    def get_raw_response
      resp = ""
      until socket.closed? || socket.eof?
        partial_data = socket.gets(256)
        break if partial_data.nil?
        puts "reading stuff :)"
        resp += partial_data
      end
      puts "finished reading stuff :)"
      resp
    end

    def close
      socket.close
    end

    def open_socket(socket_type = :tcp)
      socket_type = socket_type.to_sym
      if socket_type == :tcp
        TCPSocket.open(host,port)
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
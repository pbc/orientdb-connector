require "socket"

module OrientDBConnector
  module Utils

    class OperationTimeoutError < StandardError
      def message
        "current operation has timed out"
      end
    end

    class TCPSocket

      def initialize(host, port, operation_timeout = nil, connection_timeout = nil)

        # [["AF_INET", 0, "localhost", "127.0.0.1", 2, 1, 6],  # PF_INET/SOCK_STREAM/IPPROTO_TCP
        #  ["AF_INET", 0, "localhost", "127.0.0.1", 2, 2, 17], # PF_INET/SOCK_DGRAM/IPPROTO_UDP
        #  ["AF_INET", 0, "localhost", "127.0.0.1", 2, 3, 0]]  # PF_INET/SOCK_RAW/IPPROTO_IP

        # get IPv4 address (fixes issue with OSX and Macs which sometimes provide IPv6 address)
        @host = Socket.getaddrinfo(host, nil, Socket::AF_INET).first[3]
        @port = port.to_i
        @operation_timeout = operation_timeout
        @connection_timeout = connection_timeout

        # connection type we need - IPv4, SOCK_STREAM, IPPROTO_TCP
        @socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
        @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

        @socket_address_inet = Socket.pack_sockaddr_in(@port, @host)

        prepare_initial_connection
      end

      def prepare_initial_connection

        # If the exception is Errno::EINPROGRESS,
        # it is extended by IO::WaitWritable or IO::WaitReadable. So they can be used to rescue
        # the exceptions for retrying connect_nonblock.
        begin

          @socket.connect_nonblock(@socket_address_inet)

        rescue IO::WaitReadable

          wait_for_readable_state(@connection_timeout)
          @socket.connect_nonblock(@socket_address_inet)

        rescue IO::WaitWritable

          wait_for_writable_state(@connection_timeout)
          @socket.connect_nonblock(@socket_address_inet)

        rescue Errno::EISCONN
          # do nothing if already connected
        end

      end

      def write(content)
        wait_for_writable_state
        @socket.write content
      end

      def read
        wait_for_readable_state

        data = ""
        partial_read_length = 256

        begin
          while partial_data = @socket.read_nonblock(partial_read_length)
            data << partial_data
            break if partial_read_length > partial_data.to_s.length
          end
        rescue Errno::EAGAIN
          wait_for_readable_state
          retry
        rescue Errno::EOFError
          # do nothing
        end

        data.length > 0 ? data : nil
      end

      def close
        @socket.close
      end

      def wait_for_writable_state(custom_timeout = nil)
        # wait for the connection to become writable
        # ( wait_for_read_array, wait_for_write_array, wait_for_exception_array, timeout )
        result = IO.select(nil,[@socket], nil, (custom_timeout || @operation_timeout))
        raise OperationTimeoutError.new if result.nil?
      end

      def wait_for_readable_state(custom_timeout = nil)
        # wait for the connection to become readable
        # ( wait_for_read_array, wait_for_write_array, wait_for_exception_array, timeout )
        result = IO.select([@socket], nil, nil, (custom_timeout || @operation_timeout))
        raise OperationTimeoutError.new if result.nil?
      end

    end
  end
end
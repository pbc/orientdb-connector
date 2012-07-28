require "socket"

module OrientDBConnector
  module Utils
    class TCPSocket

      def initialize(host,port,operation_timeout=0.2)

        # [["AF_INET", 0, "localhost", "127.0.0.1", 2, 1, 6],  # PF_INET/SOCK_STREAM/IPPROTO_TCP
        #  ["AF_INET", 0, "localhost", "127.0.0.1", 2, 2, 17], # PF_INET/SOCK_DGRAM/IPPROTO_UDP
        #  ["AF_INET", 0, "localhost", "127.0.0.1", 2, 3, 0]]  # PF_INET/SOCK_RAW/IPPROTO_IP

        # get IPv4 address (fixes issue with OSX and Macs which sometimes provide IPv6 address)
        @host = Socket.getaddrinfo(host, nil, Socket::AF_INET).first[3]
        @port = port.to_i
        @operation_timeout = operation_timeout

        # connection type we need - IPv4, SOCK_STREAM, IPPROTO_TCP
        @socket = Socket.new(Socket::AF_INET,Socket::SOCK_STREAM, 0)
        @socket_address_inet = Socket.pack_sockaddr_in(@port, @host)
        prepare_initial_connection
      end

      def prepare_initial_connection

        begin
          @socket.connect_nonblock(@socket_address_inet)

        # If the exception is Errno::EINPROGRESS,
        # it is extended by IO::WaitWritable. So IO::WaitWritable can be used to rescue
        # the exceptions for retrying connect_nonblock.
        rescue IO::WaitWritable

          wait_for_writable_state

          begin
            # check connection again
            @socket.connect_nonblock(@socket_address_inet)

          rescue Errno::EISCONN
            # do nothing if already connected
          end
        end

      end

      def write(content)
        wait_for_writable_state
        @socket.write content
      end

      # IO.read needs a positive integer to trigger binary mode and prevent any character conversions
      def read_nonblock(length=256)
        data = ""
        current_retry_count = 0
        max_continuous_retry_count = 2

        begin
          data << @socket.read_nonblock(length)
          current_retry_count = 0
        rescue IO::WaitReadable
          current_retry_count += 1
          wait_for_readable_state
          retry if current_retry_count < max_continuous_retry_count
        rescue EOFError
          #do nothing
        end
        !data.nil? && data.length > 0 ? data : nil
      end

      def gets
        data = ""
        while partial_data = read_nonblock()
          data << partial_data
        end
        data.length > 0 ? data : nil
      end

      def close
        @socket.close
      end

      def wait_for_writable_state
        # wait for the connection to become writable
        # ( wait_for_read_array, wait_for_write_array, wait_for_exception_array, timeout )
        IO.select(nil,[@socket], nil, @operation_timeout)
      end

      def wait_for_readable_state
        # wait for the connection to become readable
        # ( wait_for_read_array, wait_for_write_array, wait_for_exception_array, timeout )
        IO.select([@socket], nil, nil, @operation_timeout)
      end

    end
  end
end
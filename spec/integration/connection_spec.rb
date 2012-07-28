
require "spec_helper"

describe "Connection" do

  let(:client) { OrientDBConnector::Client.new() }
  let(:disconnected_client) { OrientDBConnector::Client.new(OrientDBConnector::Base.config.connection_params.merge({:port => 3000})) }

  context "client" do

    it "should be able to establish connection" do
      client.connection_params.should == ORIENT_CONN_PARAMS
      client.use_connection do |conn|
        conn.host.should == "localhost"
        conn.port.should == 2424
        conn.socket.should be_a(OrientDBConnector::Utils::TCPSocket)
      end
      client.close_connection
    end

  end

  context "connection" do

    # Request: (driver-name:string)(driver-version:string)(protocol-version:short)(client-id:string)(user-name:string)(user-password:string)
    # Response: (session-id:int)
    it "should be able to send binary requests" do

      request = OrientDBConnector::Commands::Requests::Connect.new()
      request.driver_name = "123foo bar driver"
      request.driver_version = "1.2.3"
      request.protocol_version = 12
      request.client_id = ""
      request.user_name = "root"
      request.user_password = "root"

      #lambda {
      client.use_connection do |conn|
        puts "getting protocol number"
        puts conn.get_raw_response.inspect
        #puts request.to_binary_s.inspect
        #conn.send_raw_request(request.to_binary_s)
        #puts conn.get_raw_response.inspect
      end

      client.close_connection

      #}.should_not raise_error()

      #print request.to_binary_s


    end

  end

end

require "spec_helper"

describe "Connection" do

  let(:client) { OrientDBConnector::Client.new() }

  context "client" do

    it "should be able to establish connection" do
      client.connection_params.should == ORIENT_CONN_PARAMS
      client.use_connection do |conn|
        conn.host.should == "localhost"
        conn.port.should == 2424
        conn.socket.should be_a(TCPSocket)
      end
      client.close_connection
    end

  end

  context "connection" do

    # Request: (driver-name:string)(driver-version:string)(protocol-version:short)(client-id:string)(user-name:string)(user-password:string)
    # Response: (session-id:int)
    it "should be able to send binary requests" do
      OrientDBConnector::Commands::Requests::Connect
      OrientDBConnector::Commands::Responses::Connect
      client.use_connection do |conn|
        conn.send_raw_request("lol")
        puts "******************"
        conn.send_raw_request("lol")
        puts conn.get_raw_response
        conn.send_raw_request("lol")
        puts conn.get_raw_response
        puts "******************"
      end
      client.close
    end

  end

end
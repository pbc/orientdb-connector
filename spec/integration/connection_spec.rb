
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
      lambda {
        client.use_connection do |conn|
          request = OrientDBConnector::Commands::Request::Connect
          request.driver_name = "foo bar driver"
          request.driver_version = "1.2.3"

          conn.send_raw_request("foobar")
          conn.get_raw_response
        end
      }.should_not raise_error()
      client.close_connection
    end

  end

end
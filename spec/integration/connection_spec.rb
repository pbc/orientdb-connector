
require "spec_helper"

describe "Connection" do

  context "client" do

    it "should be able to establish connection" do
      client = OrientDBConnector::Client.new()
      client.connection_params.should == ORIENT_CONN_PARAMS
      client.use_connection do |conn|
        conn.host.should == "localhost"
        conn.port.should == 2424
        conn.socket.should be_a(TCPSocket)
      end
    end

  end

end
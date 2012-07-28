
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
    it "should be able to send CONNECT request" do

      request = OrientDBConnector::Protocol::Commands::Requests::Connect.new()
      request.session_id = -1
      request.driver_name = "OrientDBConnector driver"
      request.driver_version = OrientDBConnector::Version.current
      request.protocol_version = OrientDBConnector::Protocol::VERSION
      request.client_id = ""
      request.user_name = "test"
      request.user_password = "test"

      raw_response = ""
      response = nil

      client.use_connection do |conn|

        # fetch protocol ID
        conn.get_raw_response

        conn.send_raw_request(request.to_binary_s)
        raw_response << conn.get_raw_response

        if raw_response.getbyte(0).to_i == 1
          response = OrientDBConnector::Protocol::Commands::Responses::Error.new()
        else
          response = OrientDBConnector::Protocol::Commands::Responses::Connect.new()
        end

        response.read(raw_response)
        response.class.should == OrientDBConnector::Protocol::Commands::Responses::Connect
        response.new_session_id.should > 0
        response.session_id.should == request.session_id

      end

      client.close_connection

    end

  end

end
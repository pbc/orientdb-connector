
require "spec_helper"

describe "simple client" do

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }
  #let(:disconnected_client) { OrientDBConnector::Client.new(OrientDBConnector::Base.config.connection_params.merge({:port => 3000})) }

  it "should be able to establish connection" do
    simple_client.connection_params.should == ORIENT_CONN_PARAMS
    simple_client.use_connection do |conn|
      conn.host.should == "localhost"
      conn.port.should == 2424
      conn.socket.should be_a(OrientDBConnector::Utils::TCPSocket)
    end
    simple_client.close_all_connections
  end

  context "raw requests and sessions" do

    it "should be able to send multiple raw requests which handle sessions ids correctly and get correct raw responses" do

      request = OrientDBConnector::Protocol::Commands::Requests::Connect.new()
      request.session_id = -123
      request.driver_name = OrientDBConnector::DRIVER_NAME
      request.driver_version = OrientDBConnector::DRIVER_VERSION
      request.protocol_version = OrientDBConnector::Protocol::VERSION
      request.client_id = ""
      request.user_name = OrientDBConnector::Base.config.connection_params[:user]
      request.user_password = OrientDBConnector::Base.config.connection_params[:password]

      raw_response = ""
      response = nil

      # requesting new session ID
      simple_client.use_connection do |conn|

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
        response.session_id.should == -123

      end

      # assign new session ID
      request.session_id = response.new_session_id + 0

      # using new session ID and sending exactly the same request
      simple_client.use_connection do |conn|

        conn.send_raw_request(request.to_binary_s)
        raw_response << conn.get_raw_response

        if raw_response.getbyte(0).to_i == 1
          response = OrientDBConnector::Protocol::Commands::Responses::Error.new()
        else
          response = OrientDBConnector::Protocol::Commands::Responses::Connect.new()
        end

        response.read(raw_response)
        response.class.should == OrientDBConnector::Protocol::Commands::Responses::Connect

        response.new_session_id.should == request.session_id
        response.session_id.should == -123

      end

      simple_client.close_all_connections

    end

  end

end

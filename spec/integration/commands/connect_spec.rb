require "spec_helper"

describe "CONNECT command" do

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  it "should be possible to send CONNECT request and receive CONNECT response" do

    request = simple_client.create_request_object(:connect)
    request.class.should == OrientDBConnector::Protocol::Commands::Requests::Connect

    request.session_id = -123
    request.driver_name = OrientDBConnector::DRIVER_NAME
    request.driver_version = OrientDBConnector::DRIVER_VERSION
    request.protocol_version = OrientDBConnector::Protocol::VERSION
    request.client_id = ""
    request.user_name = OrientDBConnector::Base.config.connection_params[:user]
    request.user_password = OrientDBConnector::Base.config.connection_params[:password]

    response = simple_client.send_request(:connect, request)

    response.class.should == OrientDBConnector::Protocol::Commands::Responses::Connect
    response.new_session_id.should > 0
    response.session_id.should == -123

  end

end
require "spec_helper"

describe "DB_OPEN command" do

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "with a graph database" do

    it "should be possible to send DB_OPEN request and receive DB_OPEN response" do

      request = simple_client.create_request_object(:DBOpen)
      request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBOpen

      request.session_id = -123
      request.driver_name = OrientDBConnector::DRIVER_NAME
      request.driver_version = OrientDBConnector::DRIVER_VERSION
      request.protocol_version = OrientDBConnector::Protocol::VERSION
      request.client_id = ""
      request.database_name = GRAPH_DB_PARAMS[:name]
      request.database_type = GRAPH_DB_PARAMS[:type]
      request.user_name = OrientDBConnector::Base.config.connection_params[:user]
      request.user_password = OrientDBConnector::Base.config.connection_params[:password]

      response = simple_client.send_request(request)

      response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBOpen
      response.new_session_id.should > 0
      response.session_id.should == -123

    end

  end


end
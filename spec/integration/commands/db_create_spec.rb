require "spec_helper"

describe "DB_CREATE command" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    context "storage type 'local'" do

      it "should be possible to send DB_CREATE request and receive correct DB_CREATE response" do
        connect_response = simple_client.send_request(:connect, prepared_connect_request)

        db_create_request = simple_client.create_request_object(:db_create)
        db_create_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBCreate

        db_create_request.session_id = connect_response.new_session_id

        db_create_request.database_name = DB_PARAMS[:name] + "AAA" + rand(99999999999).to_s
        db_create_request.database_type = DB_PARAMS[:type]
        db_create_request.storage_type = "local"

        db_create_response = simple_client.send_request(:db_create, db_create_request)
        db_create_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBCreate

        db_create_response.response_status.should == 0
        db_create_response.session_id.should == connect_response.new_session_id

      end

    end

    context "storage type 'memory'" do

      #it "should be possible to send DB_CREATE request and receive correct DB_CREATE response" do
      #  connect_response = simple_client.send_request(:connect, prepared_connect_request)
      #
      #  db_create_request = simple_client.create_request_object(:db_create)
      #  db_create_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBCreate
      #
      #  db_create_request.session_id = connect_response.new_session_id
      #
      #  db_create_request.database_name = DB_PARAMS[:name] + "BBB" + rand(99999999999).to_s
      #  db_create_request.database_type = DB_PARAMS[:type]
      #  db_create_request.storage_type = "memory"
      #
      #  db_create_response = simple_client.send_request(:db_create, db_create_request)
      #  db_create_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBCreate
      #
      #  db_create_response.response_status.should == 0
      #  db_create_response.session_id.should == connect_response.new_session_id
      #
      #end

    end

  end

end
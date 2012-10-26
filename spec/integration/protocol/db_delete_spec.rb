require "spec_helper"

describe "DB_DELETE command" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    context "storage type 'local'" do

      it "should be possible to send DB_DELETE request and receive correct DB_DELETE response" do
        connect_response = simple_client.send_request(:connect, prepared_connect_request)

        # create some random DB
        db_create_request = simple_client.create_request_object(:db_create)
        db_create_request.session_id = connect_response.new_session_id

        random_db_name = DB_PARAMS[:name] + "AAA" + rand(99999999999).to_s

        db_create_request.database_name = random_db_name
        db_create_request.database_type = DB_PARAMS[:type]
        db_create_request.storage_type = "local"

        db_create_response = simple_client.send_request(:db_create, db_create_request)

        # check if created DB exists
        db_delete_request = simple_client.create_request_object(:db_delete)
        db_delete_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBDelete

        db_delete_request.session_id = connect_response.new_session_id
        db_delete_request.database_name = random_db_name

        db_delete_response = simple_client.send_request(:db_delete, db_delete_request)
        db_delete_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBDelete

        db_delete_response.response_status.should == 0
        db_delete_response.session_id.should == connect_response.new_session_id

        # trigger errors
        second_db_delete_response = simple_client.send_request(:db_delete, db_delete_request)
        second_db_delete_response.class.should == OrientDBConnector::Protocol::Commands::Responses::Error

        simple_client.close_all_connections

      end

    end

    context "storage type 'memory'" do

      it "should be possible to send DB_DELETE request and receive correct DB_DELETE response" do
        connect_response = simple_client.send_request(:connect, prepared_connect_request)


        # create some random DB
        db_create_request = simple_client.create_request_object(:db_create)
        db_create_request.session_id = connect_response.new_session_id

        random_db_name = DB_PARAMS[:name] + "BBB" + rand(99999999999).to_s

        db_create_request.database_name = random_db_name
        db_create_request.database_type = DB_PARAMS[:type]
        db_create_request.storage_type = "memory"

        db_create_response = simple_client.send_request(:db_create, db_create_request)

        # check if created DB exists
        db_delete_request = simple_client.create_request_object(:db_delete)
        db_delete_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBDelete

        db_delete_request.session_id = connect_response.new_session_id
        db_delete_request.database_name = random_db_name

        db_delete_response = simple_client.send_request(:db_delete, db_delete_request)
        db_delete_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBDelete

        db_delete_response.response_status.should == 0
        db_delete_response.session_id.should == connect_response.new_session_id

        # trigger errors
        second_db_delete_response = simple_client.send_request(:db_delete, db_delete_request)
        second_db_delete_response.class.should == OrientDBConnector::Protocol::Commands::Responses::Error

        simple_client.close_all_connections

      end

    end

  end

end
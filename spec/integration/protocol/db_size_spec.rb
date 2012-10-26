require "spec_helper"

describe "DB_SIZE command" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    it "should be possible to send DB_SIZE request and receive correct DB_SIZE response" do
      db_open_response = simple_client.send_request(:db_open, prepared_db_open_request)

      # check the DB size
      db_size_request = simple_client.create_request_object(:db_size)
      db_size_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBSize

      db_size_request.session_id = db_open_response.new_session_id

      db_size_response = simple_client.send_request(:db_size, db_size_request)
      db_size_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBSize

      db_size_response.response_status.should == 0
      db_size_response.session_id.should == db_open_response.new_session_id

      db_size_response.size_in_bytes.should > 4000

      simple_client.close_all_connections
    end

  end

end
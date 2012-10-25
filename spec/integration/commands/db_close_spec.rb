require "spec_helper"

describe "DB_CLOSE command" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    it "should be possible to send DB_CLOSE request which will close the socket on server's side" do

      db_open_response = simple_client.send_request(:db_open, prepared_db_open_request)

      db_close_request = simple_client.create_request_object(:db_close)
      db_close_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBClose
      db_close_request.session_id = db_open_response.new_session_id

      db_close_response = simple_client.send_request(:db_close, db_close_request)
      db_close_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBClose

      # DB wont return anything, it will just close the connection
      simple_client.last_raw_response.should == nil

    end

  end

end
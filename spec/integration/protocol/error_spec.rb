require "spec_helper"

describe "ERROR response" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    it "should be possible to receive correct ERROR response when required" do
      connect_request = prepared_connect_request
      connect_request.user_name = "Mr Foo Bar"
      connect_response = simple_client.send_request(:connect, connect_request)

      connect_response.class.should == OrientDBConnector::Protocol::Commands::Responses::Error

      simple_client.close_all_connections

    end

  end

end
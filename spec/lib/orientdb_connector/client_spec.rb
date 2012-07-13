require "spec_helper"
require "lib/orientdb_connector"

describe OrientDBConnector::Client do

  let(:client) { OrientDBConnector::Client.new }

  it "should be able to open connection" do
    client.should respond_to(:open_connection)
  end

  it "should be able to close connection" do
    client.should respond_to(:close_connection)
  end

  describe "#connection_params" do

    it "should return hash" do
      client.connection_params.should be_a(Hash)
    end

    it "should return available connection parameters from OrientDBConnector configuration" do
      ::OrientDBConnector::Base.config.stub(:connection_params).and_return({:foo => 123})
      client.connection_params.should == {:foo => 123}
    end

  end

end
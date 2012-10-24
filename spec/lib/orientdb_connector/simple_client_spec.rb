require "spec_helper"
require "lib/orientdb_connector"


describe OrientDBConnector::SimpleClient do

  let(:simple_client) { OrientDBConnector::SimpleClient.new }

  describe "#connection_params" do

    it "should return hash" do
      simple_client.connection_params.should be_a(Hash)
    end

    it "should return available connection parameters from OrientDBConnector configuration" do
      ::OrientDBConnector::Base.config.stub(:connection_params).and_return({:foo => 123})
      simple_client.connection_params.should == {:foo => 123}
    end

  end

  describe "#use_connection" do

    context "used with a block" do

      it "should return current SimpleClient instance when done executing block parameter" do
        simple_client.use_connection {}.should == simple_client
      end

      it "should get the connection from the pool" do
        simple_client.connection_pool.should_receive(:with_connection)
        simple_client.use_connection do
        end
      end

      it "should pass the connection to the block" do
        stubbed_block = lambda {|conn| conn.should be_a(OrientDBConnector::Connection) }
        simple_client.use_connection(&stubbed_block)
      end

    end


  end


  describe "#close_all_connections" do
    it "should close pool connections" do
      simple_client.instance_variable_get(:@connection_pool).should_receive :close
      simple_client.close_all_connections
    end
  end

  describe "#create_request_object" do
    it "should return request object created by request factory" do
      ::OrientDBConnector::Protocol::Commands::RequestFactory.stub(:create).and_return(:foo)
      simple_client.create_request_object(:some_type).should == :foo
    end
  end

  describe "#create_response_object" do
    it "should return request object created by request factory" do
      ::OrientDBConnector::Protocol::Commands::ResponseFactory.stub(:create).and_return(:bar)
      simple_client.create_response_object(:some_type).should == :bar
    end
  end

end
require "spec_helper"
require "lib/orientdb_connector"

describe OrientDBConnector::Client do

  let(:client) { OrientDBConnector::Client.new }

  describe "#connection_params" do

    it "should return hash" do
      client.connection_params.should be_a(Hash)
    end

    it "should return available connection parameters from OrientDBConnector configuration" do
      ::OrientDBConnector::Base.config.stub(:connection_params).and_return({:foo => 123})
      client.connection_params.should == {:foo => 123}
    end

  end

  describe "#use_connection" do

    context "used with a block" do

      it "should return current Client instance when done executing block parameter" do
        client.use_connection {}.should == client
      end

      it "should get the connection from the pool" do
        client.connection_pool.should_receive(:with_connection)
        client.use_connection do
        end
      end

      it "should pass the connection to the block" do
        stubbed_block = lambda {|conn| conn.should be_a(OrientDBConnector::Connection) }
        client.use_connection(&stubbed_block)
      end

    end


  end


  describe "#close_connection" do
    it "should close pool connections" do
      client.instance_variable_get(:@connection_pool).should_receive :close
      client.close_connection
    end
  end

end
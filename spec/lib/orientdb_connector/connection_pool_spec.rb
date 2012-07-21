require "spec_helper"

describe OrientDBConnector::ConnectionPool do

  let(:connection_pool) { OrientDBConnector::ConnectionPool.new(connection_params: ORIENT_CONN_PARAMS) }

  it "should have correct DEFAULT_OPTIONS" do
    OrientDBConnector::ConnectionPool::DEFAULT_OPTIONS.should == {
      max_size: 5,
      timeout: 1,
      connection_params: {}
    }
  end

  context "when used with a block" do

    it "should yield connection to the block" do

      connection_pool.with_connection do |conn|
        conn.should be_a(OrientDBConnector::Connection)
      end
    end

  end

  describe "#with_connection" do

    let(:timeout_error) { OrientDBConnector::TimeoutError }

    it "should raise TimeoutError after specified amount of time if a connection can't be acquired from the pool" do
      connection_pool.instance_variable_set(:@max_size, 0)
      connection_pool.instance_variable_set(:@timeout, 0.5)
      lambda {
        connection_pool.with_connection {}
      }.should raise_error(timeout_error)
    end

    context "one or more connections available" do

      it "should provide last connection from available connections" do
        connection_pool.instance_variable_set(:@available, [:foo, :bar, :baz])
        connection_pool.with_connection do |connection|
          connection.should == :baz
        end
      end

    end

    context "no available connections" do

      context "current queue length is lower than maximum pool size" do

        it "should create new connection" do
          connection_pool.instance_variable_set(:@max_size, 1569)
          connection_pool.stub(:create_new_connection).and_return(:foo)
          connection_pool.should_receive :create_new_connection
          connection_pool.with_connection do |connection|
            connection.should == :foo
          end
        end

      end

      context "current queue length is >= maximum pool size" do

        it "should release the lock on mutex and wait for a wakeup signal max 0.5 second" do
          mutex = connection_pool.instance_variable_get(:@mutex)
          connection_pool.instance_variable_get(:@mutex_condition).stub(:synchronize).and_return(nil)
          connection_pool.instance_variable_get(:@mutex_condition).stub(:wait).and_return(nil)
          connection_pool.instance_variable_set(:@timeout, 0.5)

          connection_pool.instance_variable_get(:@mutex_condition).should_receive(:wait).with(mutex, 0.5)
          connection_pool.instance_variable_set(:@max_size, 0)
          lambda {
            connection_pool.with_connection {}
          }.should raise_error(timeout_error)

          connection_pool.instance_variable_get(:@mutex_condition).should_receive(:wait).with(mutex, 0.5)
          connection_pool.instance_variable_set(:@max_size, -1)
          lambda {
            connection_pool.with_connection {}
          }.should raise_error(timeout_error)
        end

      end

    end

  end


  describe "#release_connection" do

    let(:conn_pool) { OrientDBConnector::ConnectionPool.new() }

    it "should broadcast to other threads" do
      conn = stub(foo: 123).as_null_object
      conn_pool.instance_variable_get(:@mutex_condition).should_receive(:broadcast)
      conn_pool.release_connection conn
    end

    context "when provided connection is nil" do
      it "should not add the connection to available connections" do
        conn_pool.release_connection nil
        conn_pool.instance_variable_get(:@available).member?(nil).should == false
      end
    end

    context "when provided connection is not nil" do

      it "should add the connection to available connections" do
        conn_pool.release_connection :foo
        conn_pool.instance_variable_get(:@available).member?(:foo).should == true
      end

      it "should remove the connection from currently used connections" do
        conn = stub(foo: 123).as_null_object
        conn_pool.instance_variable_get(:@currently_used).should_receive(:delete).with(conn.object_id)
        conn_pool.release_connection conn
      end

    end

  end

  describe "#current_pool_length" do

    it "should provide a sum of currently used and currently available connections" do
      connection_pool.instance_variable_set(:@available, [:foo, :bar])
      connection_pool.instance_variable_set(:@currently_used, { :foo2 => 1, :bar2 => 2, :baz3 => 3 })
      connection_pool.current_pool_length.should == 5
    end

  end

  describe "#create_new_connection" do
    it "should return new connection" do
      connection_pool.create_new_connection.should be_a(::OrientDBConnector::Connection)
    end
  end

end
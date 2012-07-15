require "spec_helper"

describe OrientDBConnector::ConnectionPool do

  describe "#with_connection" do

    let(:connection_pool) { OrientDBConnector::ConnectionPool.new() }
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

    context "when used with a block" do

      it "should yield connection to the block" do
        connection_pool.with_connection do |connection|
          connection.should be_a(OrientDBConnector::Connection)
        end
      end

    end

  end





end
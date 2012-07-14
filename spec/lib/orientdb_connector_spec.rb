
require "spec_helper"

describe "OrientDBConnector" do
  it "should specify GEM_PATH" do
    OrientDBConnector::GEM_PATH.should_not == nil
  end
end
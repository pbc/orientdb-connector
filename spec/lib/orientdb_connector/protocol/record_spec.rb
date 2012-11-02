require "spec_helper"


describe OrientDBConnector::Protocol::Record do

  let(:record) {OrientDBConnector::Protocol::Record.new()}

  context "#serialize" do
    it "should serialize " do
      pending
    end
  end

  context "#serialize_string" do
    it "should escape properly double quote characters" do
      record.serialize_string('"').should == '\"'
      record.serialize_string('" " " " " " "').should == '\" \" \" \" \" \" \"'
      record.serialize_string('"""""""').should == '\"\"\"\"\"\"\"'
    end

    it "should escape backslash characters" do
      record.serialize_string('\\').should == '\\\\'
      record.serialize_string('\\ \\ \\ \\ \\').should == '\\\\ \\\\ \\\\ \\\\ \\\\'
      record.serialize_string('\\\\\\\\\\').should == '\\\\\\\\\\\\\\\\\\\\'
    end

    it "should return correctly serialized string" do
      pending
    end
  end

  context "#deserialize" do

  end
end
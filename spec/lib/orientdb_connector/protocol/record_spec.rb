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
  end

  context "#deserialize_string" do
    it "should remove escaping from double quote characters" do
      record.deserialize_string('\"').should == '"'
      record.deserialize_string('\\" \\" \\" \\" \\" \\" \\"').should == '" " " " " " "'
      record.deserialize_string('\\"\\"\\"\\"\\"\\"\\"').should == '"""""""'
    end

    it "should remove escaping from backslash characters" do
      record.deserialize_string('\\\\').should == '\\'
      record.deserialize_string('\\\\ \\\\ \\\\ \\\\ \\\\').should == '\\ \\ \\ \\ \\'
      record.deserialize_string('\\\\\\\\\\\\\\\\\\\\').should == '\\\\\\\\\\'
    end
  end

  context "#enclose_string" do
    it "should return string enclosed with double quote characters" do
      record.enclose_string("foobar").should == '"foobar"'
    end
  end

  context "#encode_binary_content" do

    it "should encode binary content correctly using base64" do
      content = "this is a very long text\n" * 24
      record.encode_binary_content(content).should == "_dGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQK_"
    end

    it "should return any \\n line breaks" do
      content = "this is a very long text\n" * 48
      record.encode_binary_content(content).gsub("\n", "").should == record.encode_binary_content(content)
    end
  end

  context "#decode_binary_content" do
    it "should decode binary content correctly using base64" do
      encoded_content = "_dGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQKdGhpcyBpcyBhIHZlcnkgbG9uZyB0ZXh0CnRoaXMgaXMgYSB2ZXJ5IGxvbmcgdGV4dAp0aGlzIGlzIGEgdmVyeSBsb25nIHRleHQK_"
      decoded_content = "this is a very long text\n" * 24
      record.decode_binary_content(encoded_content).should == decoded_content
    end
  end


end
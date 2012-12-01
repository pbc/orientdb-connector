require "spec_helper"


describe OrientDBConnector::Protocol::Record do

  let(:record) {OrientDBConnector::Protocol::Record.new()}

  context "#serialize" do
    it "should serialize " do
      pending
    end
  end

  context "#deserialize" do
    it "should deserialize " do
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

  context "#deserialize_number" do
    it "should " do
      pending
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

  context "#serialize_boolean" do
    context "when the provided value is true" do
      it "should return string 'true'" do
        record.serialize_boolean(true).should == "true"
      end
    end

    context "when the provided value is false" do
      it "should return string 'false'" do
        record.serialize_boolean(false).should == "false"
      end
    end
  end

  context "#deserialize_boolean" do
    context "when the provided value is a string 'true'" do
      it "should return boolean true" do
        record.deserialize_boolean("true").should === true
      end
    end

    context "when the provided value is a string 'false'" do
      it "should return boolean false" do
        record.deserialize_boolean("false").should === false
      end
    end

    context "provided string is not 'true' or 'false'" do
      it "should raise an error" do
        error_message = "provided encoded value is invalid for a Boolean"
        lambda {
          record.deserialize_boolean(" false ")
        }.should raise_error(StandardError, error_message)

        lambda {
          record.deserialize_boolean(" true ")
        }.should raise_error(StandardError, error_message)

        lambda {
          record.deserialize_boolean(" dskjhf jsdhfg ajsd ").should === false
        }.should raise_error(StandardError, error_message)
      end
    end
  end

  context "#is_encoded_boolean?" do

    context "provided string is not 'true' or 'false'" do
      it "should be false" do
        record.is_encoded_boolean?(" true ").should === false
        record.is_encoded_boolean?(" false ").should === false
        record.is_encoded_boolean?(" foobar ").should === false
        record.is_encoded_boolean?("foobar").should === false
      end
    end

    context "provided string is 'true'" do
      it "should be true" do
        record.is_encoded_boolean?("true").should === true
      end
    end

    context "provided string is 'false'" do
      it "should be false" do
        record.is_encoded_boolean?("false").should === true
      end
    end
  end

  context "#serialize_datetime" do

    context "provided value is a DateTime object" do
      it "should return correctly formatted string" do
        date_time = DateTime.parse("2012-12-12 12:23:44.235")
        record.serialize_datetime(date_time).should == "1355315024235t"
      end
    end

    context "provided value is a Time object" do
      it "should return correctly formatted string" do
        date_time = Time.at(1354393072.640)
        record.serialize_datetime(date_time).should == "1354393072640t"
      end
    end

    context "provided value is not a Time or DateTime object" do
      it "should raise an error" do
        date_time = 1354393072.640
        lambda {
          record.serialize_datetime(date_time)
        }.should raise_error(StandardError, "provided value can't be serialized by this method")
      end
    end

  end

  context "#serialize_date" do
    context "provided value is a Date object" do
      it "should return correctly formatted string" do
        date_time = Date.parse("2012-12-12 00:00:00")
        record.serialize_date(date_time).should == "1355270400000a"
      end
    end

    context "provided value is not a Date object" do
      it "should raise an error" do
        date_time = 1354393072.640
        lambda {
          record.serialize_datetime(date_time)
        }.should raise_error(StandardError, "provided value can't be serialized by this method")
      end
    end
  end

end
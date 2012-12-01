require "spec_helper"

describe OrientDBConnector::Protocol::Number do

  let(:number_class) {OrientDBConnector::Protocol::Number}

  context "#to_s" do
    context "when current value is an Integer >= 0" do
      it "should return correct string" do
        number_class.new(12342387456923874659823476539824756928347562938476582934765).to_s.should == "12342387456923874659823476539824756928347562938476582934765"
      end
    end

    context "when current value is an Integer < 0" do
      it "should return correct string" do
        number_class.new(-12342387456923874659823476539824756928347562938476582934765).to_s.should == "-12342387456923874659823476539824756928347562938476582934765"
      end
    end

    context "when current value is a Float >= 0.0" do
      it "should return correct string" do
        number_class.new(12342387456923874659823476539824756928347562938476582934765.5529034852039485198237648723648927364892736428937460055666).to_s.should == "1.2342387456923875E+58"
      end
    end

    context "when current value is a Float < 0.0" do
      it "should return correct string" do
        number_class.new(-12342387456923874659823476539824756928347562938476582934765.5529034852039485198237648723648927364892736428937460055666).to_s.should == "-1.2342387456923875E+58"
      end
    end

    context "when current value is a BigDecimal >= 0.0" do
      it "should return correct string" do
        number_class.new(BigDecimal.new("12342345234523452345234523452345234523456575.55556663453245234523452345234523453245")).to_s.should == "12342345234523452345234523452345234523456575.55556663453245234523452345234523453245"
      end
    end

    context "when current value is a BigDecimal < 0.0" do
      it "should return correct string" do
        number_class.new(BigDecimal.new("-12342345234523452345234523452345234523456575.55556663453245234523452345234523453245")).to_s.should == "-12342345234523452345234523452345234523456575.55556663453245234523452345234523453245"
      end
    end
  end

  context "#type_code" do

    let(:num) { number_class.new(nil) }

    context "when current values type doesn't match any of the required types" do
      it "should return nil" do
        num.type_code.should == nil
      end
    end

    context "when current value is of 'float' type" do
      it "should return 'f'" do
        num.stub(:is_of_float_type?).and_return(true)
        num.type_code.should == "f"
      end
    end

    context "when current value is of 'double' type" do
      it "should return 'd'" do
        num.stub(:is_of_double_type?).and_return(true)
        num.type_code.should == "d"
      end
    end

    context "when current value is of 'big decimal' type" do
      it "should return 'c'" do
        num.stub(:is_of_big_decimal_type?).and_return(true)
        num.type_code.should == "c"
      end
    end

    context "when current value is of 'byte' type" do
      it "should return 'b'" do
        num.stub(:is_of_byte_type?).and_return(true)
        num.type_code.should == "b"
      end
    end

    context "when current value is of 'short' type" do
      it "should return 's'" do
        num.stub(:is_of_short_type?).and_return(true)
        num.type_code.should == "s"
      end
    end

    context "when current value is of 'int' type" do
      it "should return empty string" do
        num.stub(:is_of_int_type?).and_return(true)
        num.type_code.should == ""
      end
    end

    context "when current value is of 'long' type" do
      it "should return 'l'" do
        num.stub(:is_of_long_type?).and_return(true)
        num.type_code.should == "l"
      end
    end

  end

  context "#has_integer_value?" do
    it "should return true if #value is an Integer" do
      number_class.new(123).has_integer_value?.should == true
    end
  end

  context "#has_float_value?" do
    it "should return true if #value is a Float" do
      number_class.new(123.12).has_float_value?.should == true
    end
  end

  context "#has_big_decimal_value?" do
    it "should return true if #value is a Float" do
      number_class.new(BigDecimal.new("123.12")).has_big_decimal_value?.should == true
    end
  end


  context "#is_of_byte_type?" do

    context "#value == -128" do
      it "should be true" do
        number_class.new(-128).is_of_byte_type?.should == true
      end
    end

    context "-128 < #value < 127" do
      it "should be true" do
        number_class.new(12).is_of_byte_type?.should == true
      end
    end

    context "#value == 127" do
      it "should be true" do
        number_class.new(127).is_of_byte_type?.should == true
      end
    end

  end

  context "#is_of_short_type?" do

    context "#value == -32768" do
      it "should be true" do
        number_class.new(-32768).is_of_short_type?.should == true
      end
    end

    context "-32768 < #value < -128" do
      it "should be true" do
        number_class.new(-129).is_of_short_type?.should == true
        number_class.new(-32767).is_of_short_type?.should == true
      end
    end

    context "127 < #value < 32767" do
      it "should be true" do
        number_class.new(128).is_of_short_type?.should == true
        number_class.new(32766).is_of_short_type?.should == true
      end
    end

    context "#value == 32767" do
      it "should be true" do
        number_class.new(32767).is_of_short_type?.should == true
      end
    end
    
  end
  
  context "#is_of_int_type?" do

    context "#value == -2147483648" do
      it "should be true" do
        number_class.new(-2147483648).is_of_int_type?.should == true
      end
    end

    context "-2147483648 < #value < -32768" do
      it "should be true" do
        number_class.new(-32769).is_of_int_type?.should == true
        number_class.new(-2147483647).is_of_int_type?.should == true
      end
    end

    context "32767 < #value < 2147483647" do
      it "should be true" do
        number_class.new(32768).is_of_int_type?.should == true
        number_class.new(2147483646).is_of_int_type?.should == true
      end
    end

    context "#value == 2147483647" do
      it "should be true" do
        number_class.new(2147483647).is_of_int_type?.should == true
      end
    end
    
  end
  
  context "#is_of_long_type?" do
    context "#value == -9223372036854775808" do
      it "should be true" do
        number_class.new(-9223372036854775808).is_of_long_type?.should == true
      end
    end

    context "-9223372036854775808 < #value < -2147483648" do
      it "should be true" do
        number_class.new(-2147483649).is_of_long_type?.should == true
        number_class.new(-9223372036854775807).is_of_long_type?.should == true
      end
    end

    context "2147483647 < #value < 9223372036854775807" do
      it "should be true" do
        number_class.new(2147483648).is_of_long_type?.should == true
        number_class.new(9223372036854775806).is_of_long_type?.should == true
      end
    end

    context "#value == 9223372036854775807" do
      it "should be true" do
        number_class.new(9223372036854775807).is_of_long_type?.should == true
      end
    end
  end

  context "#is_of_float_type?" do
    # has_float_value? && (is_of_positive_float_type? || is_of_negative_float_type?)
    context "number is a positive float type" do

      let(:number) { number_class.new(123456.5896) }
      it "should " do

      end
    end
  end

end























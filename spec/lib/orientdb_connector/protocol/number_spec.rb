require "spec_helper"

describe OrientDBConnector::Protocol::Record do

  let(:number_class) {OrientDBConnector::Protocol::Number}

  context "#to_s" do
    context "when current value is an Integer >= 0" do
      it "should return correct string" do
        #raise number_class.new(12342387456923874659823476539824756928347562938476582934765).to_s
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
    context "when current value is a Float" do
      it "should return 'f'" do
        number_class.new(1234.12).type_code.should == "f"
      end
    end

    context "when current value is an Integer" do

      context "number == -128" do
        it "should return 'b'" do
          number_class.new(-128).type_code.should == "b"
        end
      end

      context "-128 < number < 127" do
        it "should return 'b'" do
          number_class.new(12).type_code.should == "b"
        end
      end

      context "number == 127" do
        it "should return 'b'" do
          number_class.new(127).type_code.should == "b"
        end
      end



      context "number == -32768" do
        it "should return 'b'" do
          number_class.new(-128).type_code.should == "b"
        end
      end

      context "-128 < number < 127" do
        it "should return 'b'" do
          number_class.new(12).type_code.should == "b"
        end
      end

      context "number == 127" do
        it "should return 'b'" do
          number_class.new(127).type_code.should == "b"
        end
      end

    end
  end
end
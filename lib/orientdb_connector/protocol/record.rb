require 'base64'
require 'bigdecimal'

module OrientDBConnector
  module Protocol
    class Record
      def serialize

      end

      def deserialize

      end

      def serialize_string(content_string)
        content_string.gsub(/(\\|")/) do |match|
          "\\" + match
        end
      end

      def deserialize_string(content_string)
        content_string.gsub(/(\\(\\|"))/) do |match|
          match[1..-1]
        end
      end

      def enclose_string(str)
        '"' + str + '"'
      end

      def serialize_number(number)
        number_to_string(number) + number_type_code(number)
      end

      def number_to_string(number)
        case number
        when Float
          number.to_s
        when BigDecimal
          number.to_s("F")
        when Integer
          number.to_s
        end
      end

      def number_type_code(number)
        number_class = number.class
        if number_class == Float
          "f"
        elsif number_class == Integer && -128 <= number && number <= 127
          "b"
        elsif number_class == Integer && -32768 <= number && number <= 32767
          "s"
        elsif number_class == Integer && -2147483648 <= number && number <= 2147483647
          ""
        elsif number_class == Integer && -9223372036854775808 <= number && number <= 9223372036854775808
          "l"
        elsif number_class == Integer && (-9223372036854775808 > number || number > 9223372036854775808)
          "d"
        elsif number_class == BigDecimal
          "c"
        end
      end

      def deserialize_number(number)
        #number
      end

      def encode_binary_content(binary_content)
        "_" + Base64.encode64(binary_content.to_s).to_s.gsub("\n", "") + "_"
      end

      def decode_binary_content(encoded_content)
        Base64.decode64(encoded_content.gsub("_", "")).to_s
      end

    end
  end
end
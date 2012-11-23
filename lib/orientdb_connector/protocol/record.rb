require 'base64'

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
        number.serialize
      end

      def deserialize_number(number)
        number.deserialize
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
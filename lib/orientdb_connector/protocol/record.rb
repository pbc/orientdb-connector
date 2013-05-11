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

      def deserialize_string(encoded_content_string)
        encoded_content_string.gsub(/(\\(\\|"))/) do |match|
          match[1..-1]
        end
      end

      def enclose_string(str)
        '"' + str + '"'
      end

      def serialize_number(number)
        number.serialize
      end

      def deserialize_number(encoded_number)
        encoded_number.deserialize
      end

      def encode_binary_content(binary_content)
        "_" + Base64.encode64(binary_content.to_s).to_s.gsub("\n", "") + "_"
      end

      def decode_binary_content(encoded_content)
        Base64.decode64(encoded_content.gsub("_", "")).to_s
      end

      def serialize_boolean(boolean_value)
        boolean_value.to_s
      end

      def deserialize_boolean(encoded_value)
        return true if encoded_value === "true"
        return false if encoded_value === "false"
        raise StandardError.new("provided encoded value is invalid for a Boolean")
      end

      def is_encoded_boolean?(value)
        value.match(/\A(true|false)\z/) != nil
      end

      def serialize_datetime(value)
        return (value.to_time.to_f * 1000).to_i.to_s + "t" if value.class == DateTime
        return (value.to_f * 1000).to_i.to_s  + "t" if value.class == Time
        raise StandardError.new("provided value can't be serialized by this method")
      end

      def deserialize_datetime(encoded_value)

      end

      def serialize_date(value)
        return (value.to_time.to_f * 1000).to_i.to_s + "a" if value.class == Date
        raise StandardError.new("provided value can't be serialized by this method")
      end

      def deserialize_date(encoded_value)

      end

    end
  end
end
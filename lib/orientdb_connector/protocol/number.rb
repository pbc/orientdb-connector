module OrientDBConnector
  module Protocol
    class Number

      attr_accessor :value

      def initialize(initial_value, should_deserialize_value = false)
        initial_value = deserialize(initial_value) if should_deserialize_value
        @value = initial_value
      end

      def to_s
        if has_float_value?
          value.to_s.upcase
        elsif has_big_decimal_value?
          value.to_s("F").upcase
        elsif has_integer_value?
          value.to_s
        else
          raise StandardError.new("couldn't convert this number to string")
        end
      end

      def type_code
        if is_float_type?
          "f"
        elsif is_double_type?
          "d"
        elsif is_big_decimal_type?
          "c"
        elsif is_byte_type?
          "b"
        elsif is_short_type?
          "s"
        elsif is_int_type?
          ""
        elsif is_long_type?
          "l"
        end
      end

      def has_integer_value?
        value.is_a?(Integer)
      end

      def has_float_value?
        value.is_a?(Float)
      end

      def has_big_decimal_value?
        value.is_a?(BigDecimal)
      end

      def is_byte_type?
        has_integer_value? && -128 <= value && value <= 127
      end

      def is_short_type?
        has_integer_value? && -32768 <= value && value <= 32767
      end

      def is_int_type?
        has_integer_value? && -2147483648 <= value && value <= 2147483647
      end

      def is_long_type?
        has_integer_value? && -9223372036854775808 <= value && value <= 9223372036854775808
      end

      def is_float_type?
        has_float_value? && (is_positive_float_type? || is_negative_float_type?)
      end

      def is_positive_float_type?
        1.40129846432481707e-45 <= value && value <= 3.40282346638528860e+38
      end

      def is_negative_float_type?
        -1.40129846432481707e-45 >= value && value >= -3.40282346638528860e+38
      end

      def is_double_type?
        has_float_value? && (is_positive_double_type? || is_negative_double_type?)
      end

      def is_positive_double_type?
        4.94065645841246544e-324 <= value && value <= 1.79769313486231570e+308
      end

      def is_negative_double_type?
        -4.94065645841246544e-324 >= value && value >= -1.79769313486231570e+308
      end

      def is_big_decimal_type?
        has_big_decimal_value?
      end

      def serialize
        to_s + type_code
      end

      def deserialize(serialized_value)
        #number
      end

    end
  end
end
module OrientDBConnector
  module PrimitiveTypes
    class Bytes32 < BinData::Primitive

      endian :big

      int32  :len,  :value => lambda { data.length }
      array :data, :initial_length => :len do
        int16 :element_value
      end

      def get
        self.data
      end

      def set(v)
        self.data = v
      end
    end
  end
end

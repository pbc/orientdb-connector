module OrientDBConnector
  module PrimitiveTypes
    class CompoundString < BinData::Primitive
      int8  :len,  :value => lambda { data.length }
      string :data, :read_length => :len

      def get;   self.data; end
      def set(v) self.data = v; end
    end
  end
end

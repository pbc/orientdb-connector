module OrientDBConnector
  module BinaryTypes
    module Primitive
    end
  end
end

Dir[File.join("lib/orientdb_connector/binary_types/primitive/*.rb")].each {|f| require f.gsub(/^lib\//, "")}
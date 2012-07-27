module OrientDBConnector
  module PrimitiveTypes
  end
end

Dir[File.join("lib/orientdb_connector/primitive_types/*.rb")].each {|f| require f.gsub(/^lib\//, "")}
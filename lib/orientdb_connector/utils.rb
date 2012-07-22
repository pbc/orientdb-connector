module OrientDBConnector
  module Utils
  end
end

Dir[File.join("lib/orientdb_connector/utils/*.rb")].each {|f| require f.gsub(/^lib\//, "")}

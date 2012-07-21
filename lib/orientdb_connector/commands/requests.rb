module OrientDBConnector
  module Commands
    module Requests
    end
  end
end

Dir[File.join("lib/orientdb_connector/commands/requests/*.rb")].each {|f| require f.gsub(/^lib\//, "")}

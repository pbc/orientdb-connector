module OrientDBConnector
  module Protocol
    module Commands
      module Requests
      end
    end
  end
end

Dir[File.join("lib/orientdb_connector/protocol/commands/requests/*.rb")].each {|f| require f.gsub(/^lib\//, "")}

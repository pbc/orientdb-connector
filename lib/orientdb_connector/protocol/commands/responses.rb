module OrientDBConnector
  module Protocol
    module Commands
      module Responses
      end
    end
  end
end

Dir[File.join("lib/orientdb_connector/protocol/commands/responses/*.rb")].each {|f| require f.gsub(/^lib\//, "")}
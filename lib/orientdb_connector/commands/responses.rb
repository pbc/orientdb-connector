module OrientDBConnector
  module Commands
    module Responses
    end
  end
end

Dir[File.join("lib/orientdb_connector/commands/responses/*.rb")].each {|f| require f.gsub(/^lib\//, "")}
module OrientDBConnector
  module Protocol
    VERSION = 12
  end
end

require "orientdb_connector/protocol/operation_types"
require "orientdb_connector/protocol/response_statuses"

require "orientdb_connector/protocol/commands"
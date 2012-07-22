
module OrientDBConnector
  GEM_PATH = File.dirname(File.expand_path(__FILE__)) if !const_defined?(:GEM_PATH)
end

require "bindata"

require "orientdb_connector/version"
require "orientdb_connector/config"
require "orientdb_connector/base"
require "orientdb_connector/utils"

require "orientdb_connector/connection"
require "orientdb_connector/connection_pool"
require "orientdb_connector/client"

require "orientdb_connector/commands"

require "bindata"
require "bigdecimal"
require "orientdb_connector/version"

module OrientDBConnector
  GEM_PATH = File.dirname(File.expand_path(__FILE__)) if !const_defined?(:GEM_PATH)

  DRIVER_NAME = "OrientDBConnector driver"
  DRIVER_VERSION = OrientDBConnector::Version.current

end


require "orientdb_connector/config"
require "orientdb_connector/base"
require "orientdb_connector/utils"

require "orientdb_connector/connection"
require "orientdb_connector/connection_pool"
require "orientdb_connector/simple_client"

require "orientdb_connector/binary_types"
require "orientdb_connector/protocol"



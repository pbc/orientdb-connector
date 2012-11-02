require "rubygems"
require "bundler/setup"

require 'simplecov'
#SimpleCov.start

require "orientdb_connector"

Dir[File.join("spec/support/**/*.rb")].each {|f| require f}

ORIENT_CONN_PARAMS = {
  host: "localhost",
  port: 2424,
  socket_type: "tcp",
  socket_operation_timeout: 0.6,
  socket_connection_timeout: 3,
  user: "test",
  password: "test"
}

# create database local:/home/myusername/servers/orient/releases/databases/orientdb_connector/development_document test test local

DOCUMENT_DB_PARAMS = {
:name => "orientdb_connector/development_document",
:type => "document"
}

# create database local:/home/myusername/servers/orient/releases/databases/orientdb_connector/development_graph test test local
# ALTER DATABASE TYPE graph

GRAPH_DB_PARAMS = {
  :name => "orientdb_connector/development_graph",
  :type => "graph"
}

# select correct assignment here to test with different types of databases
#
# DB_PARAMS = DOCUMENT_DB_PARAMS
DB_PARAMS = GRAPH_DB_PARAMS


OrientDBConnector::Base.configure do
  config.connection_params = ORIENT_CONN_PARAMS
end

RSpec.configure do |config|

end



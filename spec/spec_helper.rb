require "rubygems"
require "bundler/setup"

require 'simplecov'
SimpleCov.start

require "orientdb_connector"

Dir[File.join("spec/support/**/*.rb")].each {|f| require f}

ORIENT_CONN_PARAMS = {
  host: "localhost",
  port: 2424,
  socket_type: "tcp",
  user: "test",
  password: "test"
}

GRAPH_DB_PARAMS = {
  :name => "orientdb_connector/development_graph",
  :type => "graph"
}

DOCUMENT_DB_PARAMS = {
  :name => "orientdb_connector/development_document",
  :type => "document"
}

OrientDBConnector::Base.configure do
  config.connection_params = ORIENT_CONN_PARAMS
end

RSpec.configure do |config|

end



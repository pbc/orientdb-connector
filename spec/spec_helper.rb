require "rubygems"
require "bundler/setup"

require "orientdb_connector"

Dir[File.join("spec/support/**/*.rb")].each {|f| require f}

ORIENT_CONN_PARAMS = {
  host: "localhost",
  port: 2424,
  socket_type: "tcp"
}

OrientDBConnector::Base.configure do
  config.connection_params = ORIENT_CONN_PARAMS
end

RSpec.configure do |config|

end



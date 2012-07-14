require "rubygems"
require "bundler/setup"

require "orientdb_connector"

Dir[File.join("spec/support/**/*.rb")].each {|f| require f}

OrientDBConnector::Base.config.connection_params = {
  port: 2424,
  host: "127.0.0.1"
}

RSpec.configure do |config|

end



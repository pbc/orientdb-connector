# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require './lib/orientdb_connector/version'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = OrientDBConnector::Version.current
  gem.name = "orientdb-connector"
  gem.homepage = "http://github.com/pbc/orientdb-connector"
  gem.license = "MIT"
  gem.summary = %Q{OrientDB Connector allows to connect to an OrientDB Server using the binary protocol}
  gem.description = %Q{}
  gem.email = "pawel.barcik@gmail.com"
  gem.authors = ["Pawel Barcik"]
  gem.require_path = '.'
  gem.add_dependency('bindata', '~> 1.4.4')
end
Jeweler::RubygemsDotOrgTasks.new


task :default => :test

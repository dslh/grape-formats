$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.setup :default, :test

require 'grape'
require 'rack/test'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.raise_errors_for_deprecations!

  config.before(:each) { Grape::Util::InheritableSetting.reset_global! }
end

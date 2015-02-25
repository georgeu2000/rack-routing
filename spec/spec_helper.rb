require 'rack'
require 'rspec'
require 'rack/test'
 
require './lib/rack/routing'

ROUTES_FILE = 'spec/config/routes.txt'
ROUTES = Rack::Routing::Router.load_routes

RSpec.configure do |config|
  config.filter_run focus:true
  config.run_all_when_everything_filtered = true
  config.color = true

  include Rack::Test::Methods

  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /rbenv/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]
  
  config.before( :each ) do
  end
end

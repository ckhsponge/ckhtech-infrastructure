
require "#{File.dirname(__FILE__)}/application"

use Rack::JSONBodyParser

# map( "/users" ) { run UsersController }
map( "/" ) { run SinsController }

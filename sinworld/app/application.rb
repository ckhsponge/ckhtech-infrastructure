require 'rack'
require 'rack/contrib'
require 'rack/contrib/post_body_content_type_parser'

# require 'sinatra' # classic
require 'sinatra/base' # modular
require "sinatra/namespace"
require "sinatra/json"
require 'padrino-helpers'
# require 'sinatra/ratpack'
# require 'sinatra/assets/helpers'
require "dotenv" if Sinatra::Base.development?
require 'json'
require 'haml'
require 'securerandom'
require 'digest'

# gems from github go in the bundler directory
load_paths = Dir['./vendor/bundle/ruby/**/bundler/gems/**/lib']
$LOAD_PATH.unshift(*load_paths)

APP_ROOT = File.dirname(__FILE__)

def development?
  Sinatra::Base.development?
end

Dotenv.load('../.env') if development?

# Dir["#{APP_ROOT}/lib/*.rb"].each {|file| require file }
Dir["#{APP_ROOT}/initializers/*.rb"].each {|file| require file }
# require "#{APP_ROOT}/models/record_base.rb"
Dir["#{APP_ROOT}/models/*.rb"].each {|file| require file }
Dir["#{APP_ROOT}/helpers/*.rb"].each {|file| require file }
Dir["#{APP_ROOT}/controllers/*.rb"].each {|file| require file }

RecordBase.create_table_if_needed


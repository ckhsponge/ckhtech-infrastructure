class BaseController < Sinatra::Application
  def development?
    Sinatra::Base.development?
  end
  set :root, APP_ROOT
  set :views, Proc.new { File.join(root, "views") }

  use Rack::Session::Cookie,
      :key => 'rack.session',
      # :httponly     => true,
      # :same_site    => :none,
      # :secure       => true,
      # domain: ".#{HOST_BASE}", # session available to all subdomains
      #:path => '/',
      expire_after: 2592000*12*5, # 5 years
      secret:  ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

  set :public_folder, APP_ROOT + '/public'
  set :port, (ENV['RACK_ENV'] == 'production' ? 80 : 9292)

  puts "PUBLIC #{APP_ROOT + '/public'}"


  helpers HelpersMain
  helpers HelpersRatpack

end

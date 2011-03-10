require 'sinatra/base'

class SlingshotApp < Sinatra::Base
  set :logging, true
  set :dump_errors, true
  
  post '/' do
    content_type :text
    Runner.run_script(params)
  end
end
    
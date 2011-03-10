require 'sinatra/base'

class SlingshotApp < Sinatra::Base
  set :logging, true
  set :dump_errors, true
  
  post '/' do
    content_type :text
    unknown_parameters = params.keys.reject { |a| SlingshotConfig.arguments.keys.include? a }
    
    if unknown_parameters.length > 0
      halt 403, "Unknown parameter(s) #{unknown_parameters.join(', ')}\n"
    end
      
    Runner.run_script(params)
  end
end
    
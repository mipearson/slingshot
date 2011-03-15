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
      
    (code, text) = Runner.run_script(params)
    if code != 0
      halt 500, text + "\n\nScript returned a non-zero response code of #{code}.\n"
    end
    text
  end
end
    
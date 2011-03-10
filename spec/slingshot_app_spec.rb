require 'spec_helper'
require 'rack/test'

describe SlingshotApp do
  include Rack::Test::Methods
  
  def app
    SlingshotApp
  end
  
  describe 'POST' do
    it "should call the Runner with the arguments provided in the query and print the output as text" do
      Runner.should_receive(:run_script).with({'bob' => 'uncle', 'fred' => 'mum'}).and_return("hey")
      post '/', :bob => 'uncle', :fred => 'mum'

      File.open('foo', 'w+') { |f| f.puts last_response.body }
      last_response.should be_ok
      last_response.body.should == 'hey'
      last_response.content_type.should =~ %r{text/plain}
    end
  end
end
      
    
    
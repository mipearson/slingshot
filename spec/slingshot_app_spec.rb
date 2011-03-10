require 'spec_helper'
require 'rack/test'

describe SlingshotApp do
  include Rack::Test::Methods
  
  def app
    SlingshotApp
  end
  
  before do
    SlingshotConfig.stub!(:arguments => {'bob' => nil, 'fred' => nil})
  end
  
  describe 'POST' do
    it "should call the Runner with the arguments provided in the query and print the output as text" do
      Runner.should_receive(:run_script).with({'bob' => 'uncle', 'fred' => 'mum'}).and_return("hey")
      post '/', :bob => 'uncle', :fred => 'mum'

      last_response.should be_ok
      last_response.body.should == 'hey'
      last_response.content_type.should =~ %r{text/plain}
    end
    
    it "should not allow the user to pass parameters that aren't configured as arguments" do
      Runner.should_not_receive(:run_script)
      post '/', :steve => 'hey'

      last_response.should_not be_ok
      last_response.content_type.should =~ %r{text/plain}
      last_response.body.should include 'Unknown parameter(s) steve'
    end
  end
end
      
    
    
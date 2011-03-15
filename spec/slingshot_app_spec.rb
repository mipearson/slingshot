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
      Runner.should_receive(:run_script).with({'bob' => 'uncle', 'fred' => 'mum'}).and_return([0, "hey"])
      post '/', :bob => 'uncle', :fred => 'mum'

      last_response.should be_ok
      last_response.body.should == 'hey'
      last_response.content_type.should =~ %r{text/plain}
    end
    
    it "should not allow the user to pass parameters that aren't configured as arguments" do
      Runner.should_not_receive(:run_script)
      post '/', :steve => 'hey'

      last_response.status.should == 403
      last_response.content_type.should =~ %r{text/plain}
      last_response.body.should include 'Unknown parameter(s) steve'
    end
    
    it "should print the output and return a 500 if the script execution fails" do
      Runner.should_receive(:run_script).and_return([1, "oh crap"])
      post '/'
      
      last_response.status.should == 500
      last_response.body.should == "oh crap\n\nScript returned a non-zero response code of 1.\n"
      last_response.content_type.should =~ %r{text/plain}
    end

  end
end
      
    
    
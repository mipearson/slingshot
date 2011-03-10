require 'spec_helper'

describe Runner do
  describe '.run_script' do
    before do
      SlingshotConfig.stub!(:script => "my_script", :dir => "app_dir", :arguments => {"bob" => "uncle", "mary" => nil})
    end
    
    it "should run the script in the application directory" do
      Runner.should_receive(:system).with('cd app_dir && my_script 1>&2')
      Runner.run_script
    end
    
    it "should set environment variables based on configuration defaults" do
      Runner.stub!(:system)
      Runner.run_script
      ENV['bob'].should == 'uncle'
      ENV.should_not include 'mary'
    end
    
    it "should override configuration defaults based on passed parameters" do
      Runner.stub!(:system)
      Runner.run_script("bob" => 'father', 'mary' => 'mother')
      ENV['bob'].should == 'father'
      ENV['mary'].should == 'mother'
    end
    
  end
end
    
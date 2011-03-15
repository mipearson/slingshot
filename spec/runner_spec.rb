require 'spec_helper'

describe Runner do
  describe '.run_script' do
    before do
      SlingshotConfig.stub!(:script => "my_script", :dir => "app_dir")
      Runner.stub!(:merge_env)
    end
    
    it "should run the script in the application directory" do
      Runner.should_receive(:`).with("bash -c 'cd app_dir && my_script' 2>&1")
      Runner.run_script
    end
    
    it "should call merge_env with our run arguments" do
      Runner.stub!(:`)
      Runner.should_receive(:merge_env).with('bob' => 'uncle')
      Runner.run_script('bob' => 'uncle')
    end
  end
  
  describe ".merge_env" do
    before do
      SlingshotConfig.stub!(:arguments => {"bob" => "uncle", "mary" => nil})
    end
    # We test this private method seperately as Bundler.with_clean_env makes
    # testing our environment difficult.
    
    it "should set environment variables based on configuration defaults" do
      Runner.send(:merge_env)
      ENV['bob'].should == 'uncle'
      ENV.should_not include 'mary'
    end
    
    it "should override configuration defaults based on passed parameters" do
      Runner.send(:merge_env, {"bob" => 'father', 'mary' => 'mother'})
      ENV['bob'].should == 'father'
      ENV['mary'].should == 'mother'
    end
  end
end
    
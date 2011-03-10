require 'spec_helper'

describe SlingshotConfig do
  
  CONFIG = %{
script: config/rails-passenger.rb
dir: ~/myapp
arguments:
  commit:
  bundler: true
  migrate: true
  restart: true
}
  
  subject {
    SlingshotConfig.reload(CONFIG)
    SlingshotConfig
  }
  
  its(:script) { should == File.join(APP_ROOT, 'config/rails-passenger.rb') }
  its(:dir) { should == File.expand_path('~/myapp') }
  its(:arguments) { should == { 'commit' => nil, 'bundler' => true, 'migrate' => true, 'restart' => true } }
end
APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))  

require 'rubygems'
require 'bundler/setup'

Dir[File.join(APP_ROOT, 'lib', '*.rb')].each { |file| require file }
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'env'))

Dir[File.join(APP_ROOT, 'spec', 'support', '**', '*.rb')].each {|f| require f}

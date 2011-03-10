require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'env'))
SlingshotConfig.reload(File.open(File.join(APP_ROOT, 'config/config.yml')).read)
run SlingshotApp
require 'singleton'
require 'yaml'

class SlingshotConfig
  
  include Singleton
  
  attr_reader :arguments, :dir, :script

  def self.method_missing(name, *args)
    if instance.respond_to?(name)
      instance.send(name, *args)
    else
      super(name, *args)
    end
  end
      
  def reload yaml
    conf = YAML.load(yaml)
    @arguments = conf['arguments']
    @dir       = File.expand_path(conf['dir'])
    @script    = File.join(APP_ROOT, conf['script'])
  end

end
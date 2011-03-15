class Runner
  def self.run_script params={}
    text = Bundler.with_clean_env do
      merge_env params
      `bash -c 'cd #{SlingshotConfig.dir} && #{SlingshotConfig.script}' 2>&1`
    end
    [$?.exitstatus, text]
  end
  
  private
  
  def self.merge_env params={}
    SlingshotConfig.arguments.merge(params).each do |param, value|
      if value.nil?
        ENV.delete(param)
      else
        ENV[param] = value.to_s
      end
    end
  end    
end

class Runner
  def self.run_script params={}
    SlingshotConfig.arguments.merge(params).each do |param, value|
      if value.nil?
        ENV.delete(param)
      else
        ENV[param] = value.to_s
      end
    end
    `bash -c 'cd #{SlingshotConfig.dir} && #{SlingshotConfig.script}' 2>&1`
  end
end
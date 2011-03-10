class Runner
  def self.run_script params={}
    SlingshotConfig.arguments.merge(params).each do |param, value|
      if value.nil?
        ENV.delete(param)
      else
        ENV[param] = value.to_s
      end
    end
    system "cd #{SlingshotConfig.dir} && #{SlingshotConfig.script} 1>&2"
  end
end
#!/usr/bin/env ruby

def run *args
  puts "> #{args.join(' ')}"
  system *args
  if $? != 0
    raise "Execution of #{args.join(' ')} failed with return code $?"
  end
end

if ENV['commit']
  run "git pull"
else
  run "git fetch" 
  run "git checkout #{ENV['commit']}"
end

run "bundle install" if ENV['bundler'] && ENV['bundler'] == 'true'
run "RAILS_ENVIRONMENT=production rake db:migrate" if ENV['migrate'] && ENV['migrate'] == 'true'
run "touch tmp/restart.txt" if ENV['restart'] && ENV['restart'] == 'true'
#!/usr/bin/env ruby

def run *args
  puts "> #{args.join(' ')}"
  system *args
  if $? != 0
    raise "Execution of #{args.join(' ')} failed with return code #{$?}"
  end
end

def enabled? var
  ENV[var] && ENV[var] == 'true'
end

if ENV['commit'] 
  run "git fetch" 
  run "git checkout #{ENV['commit']}"
else
  run "git pull"
end

ENV['RAILS_ENVIRONMENT'] ||= 'production'

run "bundle install" if enabled?('bundler')
run "rake db:migrate" if enabled?('migrate')
run "mkdir -p tmp && touch tmp/restart.txt" if enabled?('restart')

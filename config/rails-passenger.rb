#!/usr/bin/env ruby

def run *args
  puts "> #{args.join(' ')}"
  system *args
  if $? != 0
    raise "Execution of #{args.join(' ')} failed with return code #{$?}"
  end
end

if ENV['commit']
  run "git pull"
else
  run "git fetch" 
  run "git checkout #{ENV['commit']}"
end

ENV['BUNDLE_GEMFILE'] = './Gemfile'
ENV['RAILS_ENVIRONMENT'] = 'production'
run "bundle install" if ENV['bundler'] && ENV['bundler'] == 'true'
run "rake db:migrate" if ENV['migrate'] && ENV['migrate'] == 'true'
run "mkdir -p tmp && touch tmp/restart.txt" if ENV['restart'] && ENV['restart'] == 'true'

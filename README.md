# Slingshot

git pull, bundle install, rake db:migrate, touch tmp/restart.txt:

`curl -d '' http://myapp.com/slingshot/`

git fetch, git checkout release/1.1, no bundle or migrate, touch tmp/restart.txt:

`curl -d commit=release/1.1 -d migrate=false -d bundle=false http://myapp.com/slingshot/`

## Synopsis

Slingshot is a lightweight Rack-based application update mechanism. It was written to
allow our CI environment and members of a team quickly update an application.

Slingshot doesn't deploy: deployment implies "pushing" an artefact from one location to
another. Slingshot, using the default script, updates a repository checkout.

Mount Slingshot on your Rack application server anywhere. Send it a POST request to
perform an update to your nominated application.

Parameters included in the POST body will be sent through as environment variables
(sysops: see the "security" section) to a script. The name of the script, defaults, and
the directory to run the script in are configured in `config.yml`.  

## Security

Sorry, no.

Well, you could lock down the mount on your Rack application server...
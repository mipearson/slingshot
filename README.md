# Slingshot

git pull, bundle install, rake db:migrate, touch tmp/restart.txt:

`curl -d '' http://myapp.com/slingshot/`

git fetch, git checkout release/1.1, no bundle or migrate, touch tmp/restart.txt:

`curl -d commit=release/1.1 -d migrate=false -d bundle=false http://myapp.com/slingshot/`

## Synopsis

**Slingshot** is a lightweight Rack-based application update mechanism. It was written to
allow our CI environment and members of a team quickly update an application.

**Slingshot** doesn't deploy: deployment implies "pushing" an artefact from one location to
another. **Slingshot**, using the default script, updates a repository checkout.

Mount **Slingshot** on your Rack application server anywhere. Send it a POST request to
perform an update to your nominated application.

Parameters included in the POST body will be sent through as environment variables
(sysops: see the "security" section) to a script. The name of the script, defaults, and
the directory to run the script in are configured in `config.yml`.  

## Installation

    cd ~/
    gem install bundler # if you haven't already ...
    git clone git://github.com/mipearson/slingshot.git
    cd slingshot
    bundle install
    vim config/config.yml # change 'dir' to point to your application's root dir
    
### Passenger and Apache

If you want to mount **slingshot** as `/slingshot/` under existing application (thus removing
the need for additional virtual hosts or ports) you'll need to symlink the **slingshot** public directory
under your application's public directory. Eg:

    cd my_webapp/public
    ln -si ~/slingshot/public slingshot
    
An example `apache.conf` file is provided for this setup. You'll need to edit it to change the `<Directory>` 
section to point to where you cloned **slingshot**. Once you've done that:
 
    sudo ln -si ~/slingshot/config/apache.conf /etc/apache2/sites-available/slingshot.conf 
    sudo a2ensite slingshot
    sudo apache2ctl graceful

You should then be able to send a POST request to `http://mywebapp.com/slingshot/` to update your application.

## Security

Sorry, no.

Well, you could lock down the mount on your Rack application server...

## TODO

* Turn into a Rack-mountable gem.
* Add GET / to show a form to fill in deployment parameters.


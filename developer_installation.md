# Getting Up and Running

This application runs on Rails 5.0.0.1 and Ruby 2.3.1. PostgreSQL version 9 or above must also be installed for data storage.

Getting up and running should go something like this:

## Version Control

Make sure you have Git [installed and up to date](https://git-scm.com/downloads).

Make sure you are all set up on GitHub with proper [Git configuration](https://help.github.com/articles/set-up-git/) and [SSH keys](https://help.github.com/articles/generating-an-ssh-key/).

## Create Your Project Directory and Download the Source Code

    $ mkdir ~/.../kinspire
    $ cd ~/.../kinspire
    $ git clone git@github.com:nmccrea/kinspire.git

## Prepare Your Development Environment with RVM

Please use [Ruby Version Manager (RVM)](https://rvm.io/) on your development machine to isolate your Ruby development environment.

Install RVM:

    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    $ \curl -sSL https://get.rvm.io | bash -s stable

[Install Ruby 2.3.1](https://rvm.io/rubies/installing). This may take a little while:

    $ rvm install 2.3.1

[Make sure this is the version currently being used](https://rvm.io/rvm/basics):

    $ rvm 2.3.1

[Create a new gemset for our project ](https://rvm.io/gemsets/creating):

    $ rvm gemset create kinspire

Now you should be able to type:

    $ rvm use 2.3.1@kinspire

at any time to [enter the dev environment for our project](https://rvm.io/gemsets/using). Take care not to pollute your development environment with Ruby gems that are not part of our project.

Create a new file in the project root to instruct RVM to activate this gemset every time you `cd` into the project directory:

    $ echo "kinspire" >> .ruby-gemset

**Test that automatic gemset activation is working:**

Leave the project directory and change the Ruby environment to something else:

    $ cd ~
    $ rvm default
    $ rvm current
    => ruby-2.3.0        # or something similar - it should not say "kinspire"

Return to the project directory and confirm the correct environment has been reactivated:

    $ cd ~/.../kinspire
    $ rvm current
    => ruby-2.3.1@kinspire

The `.ruby-gemset` file is ignored by Git version control, since non-development environments may not use RVM.

## Install PostgreSQL

If you are on a Mac using Homebrew, you should be able to do this as follows:

Make sure Homebrew is up to date:

    $ brew update

Install PostgreSQL:

    $ brew install postgres

Initialize the database. The accepted convention for the location of Postgres files from a Homebrew install seems to be `/usr/local/var/postgres`:

    $ initdb -D /usr/local/var/postgres

Finally, you will need to actually start the database server before our app can connect to it:

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

The server can be stopped with the stop command:

    $ pg_ctl -D /usr/local/var/postgres stop

## Install Application Dependencies (Gems)

Rails uses a gem called [bundler](http://bundler.io/) to manage all of the other gems you add to your project (including the Rails gem itself). From the project's root directory:

    $ gem install bundler

Once bundler is installed, you should able to install everything else (including Rails), using:

    $ bundle install

It may take a few minutes for all the gems to install.

This command reads the contents of the file `Gemfile`, and installs all of the gems listed there along with their dependencies. Any time we want to add a new gem to the project, we will add it to the `Gemfile`, and then run `$ bundle install` again.

## Prepare the Database

From the project root:

    $ rails db:setup
    $ rails db:migrate

## Run the Application

If all has gone well up to this point (Ha!), you should be able to run:

    $ rails s

from the project root to run the application. (`rails s` is short for `rails server`.) Pointing your browser to `localhost:3000` should then display the project homepage, confirming things are working.

This should complete the setup process for now, and is enough to begin coding the application.
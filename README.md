# Mina Db Sync

Copy specific tables between your production and development databases
using [Mina](https://github.com/mina-deploy/mina) for your Rails app.
All authentication is based on your database.yml files.

## Requirements
* rsync

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-db_sync'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-db_sync

Now add the following to your config/deploy.rb file:

```ruby
require 'mina/db_sync'

# configure which database you're using:
set :db_sync_database, 'postgres' #or 'mysql'

# optionally turn on debugging, which leaves the sql file after sync:
set :db_sync_debug, true
```

## Usage

Get data from the server to your local db:

```
mina db:get_tables
```

Get data from your local db to the server:

```
mina db:put_tables
```

You'll be asked to supply the name(s) of any database tables you'd like
to be copied over. All data in the target table(s) will be removed as part
of the process, so make sure you backup first if you're paranoid.

Or you can specify the tables you want from the beginning:

    $ mina db:get_tables[table1,table2,table3]

If you're using Zsh:

    $ mina db:get_tables\[table1,table2,table3\]

## Database Support
* MySQL
* Postgresql

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


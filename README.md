# Mina Db Sync

Copy specific tables between your production and development databases
using [Mina](https://github.com/mina-deploy/mina) for your Rails app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-db_sync'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-db_sync

## Usage

Get data from the server to your local db:

```
bundle exec mina db:get_tables
```

Get data from your local db to the server:

```
bundle exec mina db:put_tables
```

You'll be asked to supply the name(s) of any database tables you'd like
to be copied over. All data in the target table(s) will be removed as part
of the process, so make sure you backup first if you're paranoid.

You'll probably find it easier to binstub mina:

```
bundle binstubs mina
```

And then:

```
bin/mina db:get_tables
bin/mina db:put_tables
```

## Database Support

Right now, this is only for postgresql, but I hope to add MySQL support in the future.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


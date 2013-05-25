# Mince Migrator

[![Travis CI](https://travis-ci.org/coffeencoke/mince_migrator.png)](https://travis-ci.org/#!/coffeencoke/mince_migrator)

Mince Migrator is a library that provides a way to run database
migrations for your ruby applications.

## Installation

    $ gem install mince_migrator

## Usage

### Generate a migration

	$ mince_migrator create "Load admin users"

### Implement your migration

The output of creating the migration will tell you where the migration was created.

Implement the `run` method with the behavior of your migration.

### Run your single migration

	$ mince_migrator run "Load admin users"
	
### Revert your single migration

	$ mince_migrator revert "Load admin users"

### Run all migrations that have not yet been ran

	$ mince_migrator run_all

### View all migrations

*My favorite!*

	$ mince_migrator list

### Check the status of a migration

	$ mince_migrator show "Load admin users"

### View all available commands

	$ mince_migrator --help

## Bootstrap your application

You can bootsrap the mince migrator by adding a file located at `config/mince_migrator.rb` in your app's root directory.

For Rails, you will want to add the following:

```
# This will load the correct database and mince interface
# for us to use to run our migrations.
environment = ENV['RAILS_ENV']||'development'

require_relative 'environment'
```

But you can add whatever you want in order to bootstrap your application in this file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Bonus contributions!

1. Talk with me first
2. Make all commits stable
3. Include tests
4. Update documentation for your added feature

Special Thanks to [@davetron5000](https://github.com/davetron5000) for writing [gli](https://github.com/davetron5000/gli)

# License

Copyright (c) 2013 Matt Simpson

MIT License

View the LICENSE.txt file included in the source

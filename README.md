# Mince Migrator

[![Travis CI](https://travis-ci.org/coffeencoke/mince_migrator.png)](https://travis-ci.org/#!/coffeencoke/mince_migrator)

**This is not yet released, this read me is a roadmap for what to do, it is not necessarily what has been done yet.**

Mince Migrator is a library that provides a way to run database migrations for your application using the [Mince libraries](https://github.com/coffeencoke/mince).

## Installation

Add this line to your application's Gemfile:

    gem 'mince_migrator'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mince_migrator

## Usage

### Generate a migration

	$ mince_migrator create "Load admin users"

### Implement your migration

The template provided to you for a migration looks like this:

```ruby
module MinceMigrator
  module Migration
  	module LoadAdminUsers
  	  def self.run
  	  	# Actual migration goes here
  	  end
  	  
  	  def self.revert
  	  	# In case you need to revert this one migration
  	  end
  	
  	  # So you can change the order to run more easily
  	  def self.time_created
  	  	"2013-02-23 19:03:27 UTC"
  	  end  	    	  
  	  
  	  module Temporary
  	  	# Migration dependent classes go here
  	  end
  	end
  end
end
```

For an evolving explanation for the Temporary module, view [Migrating With Temporary Classes](https://github.com/coffeencoke/mince_migrator/wiki/migrating-with-temporary-classes).

### Run your single migration

	$ mince_migrator run "Load admin users"
	
*You can use any of the following as the name for the above command:*

* `Load admin users` (in quotes)* 
* `LoadAdminUsers`
* `load_admin_users`

### Revert your single migration

	$ mince_migrator revert "Load admin users"

### Run all migrations that have not yet been ran

	$ mince_migrator run_all
	
### Check the status of a migration

	$ bundle exec mince_migrator status "Load admin users"

### View all available commands

*Run any of the following*

	$ mince_migrator
	$ mince_migrator --help
	$ mince_migrator help

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

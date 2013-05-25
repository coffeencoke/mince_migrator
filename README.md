# Mince Migrator

[![Travis CI](https://travis-ci.org/coffeencoke/mince_migrator.png)](https://travis-ci.org/#!/coffeencoke/mince_migrator)

Mince Migrator is a library that provides a way to run database
migrations for your ruby applications.

## 1. Install

    $ gem install mince_migrator

## 2. Use

	$ mince_migrator create Load admin users
	# Implement your migration by opening db/migration/load_admin_users.rb
	$ mince_migrator run Load admin users

## 3. Learn more

For more info, view the [home page](http://coffeencoke.github.io/mince_migrator/).

## Contributing

1. Fork it
2. Create feature branch (`git checkout -b my-new-feature`)
3. Commit changes (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Create Pull Request

## Bonus contributions!

* Talk with me first
* Make all commits stable
* Include tests
* Update documentation for your added feature

Special Thanks to [@davetron5000](https://github.com/davetron5000) for writing [gli](https://github.com/davetron5000/gli)

# License

Copyright (c) 2013 Matt Simpson

MIT License

View the LICENSE.txt file included in the source

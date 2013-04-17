module MinceMigrator
  require 'singleton'

  class Config
    include Singleton

    attr_reader :migration_relative_dir, :migration_dir

    def initialize
      self.migration_relative_dir = ::File.join("db", "migrations")
    end

    def migration_relative_dir=(val)
      @migration_relative_dir = val
      @migration_dir = ::File.join(Dir.pwd, migration_relative_dir)
    end

    def self.migration_relative_dir
      instance.migration_relative_dir
    end

    def self.migration_dir
      instance.migration_dir
    end

    def self.config_file
      ::File.join(Dir.pwd, 'config', 'mince_migrator.rb')
    end
  end
end

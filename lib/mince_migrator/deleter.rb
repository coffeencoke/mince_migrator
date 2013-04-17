module MinceMigrator
  require_relative 'config'
  require 'fileutils'
  require_relative 'migrations/name'
  require_relative 'ran_migration'

  class Deleter
    attr_reader :name

    def initialize(name)
      @name = Migrations::Name.new(name)
    end

    def delete_migration
      ::FileUtils.rm(migration_path)
      ran_migration.delete if ran_migration
    end

    def can_delete_migration?
      ::File.exists?(migration_path)
    end

    def migration_path
      ::File.join Config.migration_dir, name.filename
    end

    def ran_migration
      @ran_migration ||= RanMigration.find_by_name(name.value)
    end
  end
end

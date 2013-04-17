module MinceMigrator
  require_relative 'config'
  require 'fileutils'
  require_relative 'migrations/name'
  require_relative 'ran_migration'

  class Deleter
    attr_reader :name, :filename, :migration_name, :migration

    def initialize(options)
      if options[:migration]
        @migration = options[:migration]
        @migration_name = Migrations::Name.new(migration.name)
      elsif options[:name]
        @migration_name = Migrations::Name.new(options[:name])
      end
      @name = migration_name.value
      @filename = migration_name.filename
    end

    def delete_migration
      ::FileUtils.rm(migration_path)
      ran_migration.delete if ran_migration
    end

    def can_delete_migration?
      ::File.exists?(migration_path)
    end

    def reasons_for_failure
      "Migration does not exist with name '#{name}'" unless can_delete_migration?
    end

    def migration_path
      ::File.join Config.migration_dir, filename
    end

    def ran_migration
      @ran_migration ||= RanMigration.find_by_name(name)
    end
  end
end

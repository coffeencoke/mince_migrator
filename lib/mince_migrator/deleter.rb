module MinceMigrator
  require_relative 'migrations/file'
  require_relative 'config'
  require 'fileutils'

  class Deleter
    attr_reader :name

    def initialize(name)
      @name = name.gsub(" ", "_").downcase
    end

    def delete_migration
      ::FileUtils.rm(migration_path)
    end

    def can_delete_migration?
      ::File.exists?(migration_path)
    end

    def migration_path
      ::File.join Config.migration_dir, "#{name}.rb"
    end
  end
end

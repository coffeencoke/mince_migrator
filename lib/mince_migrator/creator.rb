module MinceMigrator
  require 'fileutils'
  require_relative 'migration_file'

  class Creator
    attr_reader :name
    def initialize(name=nil)
      @name = name
    end

    def can_create_migration?
      !!name
    end

    def create_migration
      FileUtils.mkdir_p(migration_file.path)
      File.open(migration_file.full_path, 'w+') do |f|
        f.write "Haz content"
      end
    end

    def migration_file
      @migration_file ||= MigrationFile.new(name)
    end
  end
end

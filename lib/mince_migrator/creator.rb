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
      file = File.open(migration_file.full_path, 'w+')
      file.write migration_file.body
      file.close
    end

    def migration_file
      @migration_file ||= MigrationFile.new(name)
    end

    def migration_file_relative_path
      migration_file.full_relative_path
    end

    def self.create(name)
      new(name).tap do |creator|
        creator.create_migration if creator.can_create_migration?
      end
    end
  end
end

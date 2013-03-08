module MinceMigrator
  require 'fileutils'
  require_relative 'migrations/file'
  require_relative 'config'

  class Creator
    attr_reader :name
    def initialize(name=nil)
      @name = name
    end

    def can_create_migration?
      !!name
    end

    def create_migration
      FileUtils.mkdir_p(Config.migration_dir)
      file = File.open(migration_file.full_path, 'w+')
      file.write migration_file.body
      file.close
    end

    def migration_file
      @migration_file ||= Migrations::File.new(name)
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

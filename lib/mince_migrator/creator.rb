module MinceMigrator
  require 'fileutils'
  require_relative 'migrations/versioned_file'
  require_relative 'migrations/name'
  require_relative 'config'

  class Creator
    attr_reader :name, :migration_name

    def initialize(name=nil)
      @migration_name = Migrations::Name.new(name)
      @name = migration_name.value
    end

    def can_create_migration?
      migration_name.valid?
    end

    def reasons_for_failure
      migration_name.reasons_for_failure
    end

    def create_migration
      FileUtils.mkdir_p(Config.migration_dir)
      file = ::File.open(migration_file.full_path, 'w+')
      file.write migration_file.body
      file.close
    end

    def migration_file
      @migration_file ||= versioned_file.next_unused_version
    end

    def versioned_file
      @versioned_file ||= Migrations::VersionedFile.new(name)
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

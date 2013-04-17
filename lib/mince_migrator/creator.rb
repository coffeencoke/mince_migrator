module MinceMigrator
  require 'fileutils'
  require_relative 'migrations/versioned_file'
  require_relative 'migrations/name'
  require_relative 'config'

  class Creator
    attr_reader :name

    def initialize(name=nil)
      @name = Migrations::Name.new(name)
    end

    def can_create_migration?
      name.valid?
    end

    def reasons_for_failure
      name.reasons_for_failure
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
      @versioned_file ||= Migrations::VersionedFile.new(name.value)
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

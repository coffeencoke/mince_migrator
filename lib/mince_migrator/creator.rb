module MinceMigrator
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
      File.open(migration_file.path, 'w+') do |f|
        f.write "Haz content"
      end
    end

    def migration_file
      @migration_file ||= MigrationFile.new(name)
    end
  end
end

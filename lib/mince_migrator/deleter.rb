module MinceMigrator
  class Deleter
    attr_reader :name

    def initialize(name)
      @name = name.gsub(" ", "_").downcase
    end

    def can_delete_migration?
      File.exists?(migration_path)
    end

    def migration_path
      File.join MigrationFile.path, "#{name}.rb"
    end
  end
end

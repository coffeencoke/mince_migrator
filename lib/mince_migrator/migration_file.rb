module MinceMigrator
  class MigrationFile
    attr_reader :name
    def initialize(name)
      self.name = name
    end

    def path
      File.join(Dir.pwd, "db", "migrations")
    end

    def name=(val)
      @name = val.gsub(" ", "_").downcase
    end

    def filename
      "#{name}.rb"
    end

    def full_path
      File.join path, filename
    end

    def body
      "Haz content"
    end
  end
end

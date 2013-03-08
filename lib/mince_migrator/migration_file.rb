module MinceMigrator
  require_relative 'migration_template'

  class MigrationFile
    attr_reader :name

    def initialize(name)
      self.name = name
    end

    def path
      File.join(Dir.pwd, relative_path)
    end

    def relative_path
      File.join("db", "migrations")
    end

    def full_relative_path
      File.join(relative_path, filename)
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

    def klass_name
      @klass_name ||= name.split("_").map{|a| a.capitalize }.join
    end

    def body
      @body ||= MigrationTemplate.new(klass_name).render
    end
  end
end

module MinceMigrator
  require_relative 'migration_template'

  class MigrationFile
    attr_reader :name

    def initialize(name)
      @original_name = name
      @version = 1
      self.name = name
    end

    def path
      self.class.path
    end

    def relative_path
      self.class.relative_path
    end

    def full_relative_path
      File.join(relative_path, filename)
    end

    def name=(val)
      @name = val.gsub(" ", "_").downcase
      if File.exists?(full_path)
        @version += 1
        self.name = "#{@original_name}_#{@version}"
      end
    end

    def filename
      "#{name}.rb"
    end

    def full_path
      File.join path, filename
    end

    def klass_name
      name.split("_").map{|a| a.capitalize }.join
    end

    def body
      @body ||= MigrationTemplate.new(klass_name).render
    end

    def self.path
      File.join(Dir.pwd, relative_path)
    end

    def self.relative_path
      File.join("db", "migrations")
    end
  end
end

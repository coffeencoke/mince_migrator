module MinceMigrator
  class MigrationFile
    attr_reader :name
    def initialize(name)
      self.name = name
    end

    def path
      "/tmp/#{name}.rb"
    end

    def name=(val)
      @name = val.gsub(" ", "_").downcase
    end
  end
end

module MinceMigrator
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
      name.split("_").map{|a| a.capitalize }.join
    end

    def body
<<-eos
module MinceMigrator
  module Migrations
    module #{klass_name}
      def self.run
        # Actual migration goes here
      end

      def self.revert
        # In case you need to revert this one migration
      end

      # So you can change the order to run more easily
      def self.time_created
        "#{Time.now.utc.to_s}"
      end

      module Temporary
        # Migration dependent classes go here
      end
    end
  end
end
eos
    end
  end
end

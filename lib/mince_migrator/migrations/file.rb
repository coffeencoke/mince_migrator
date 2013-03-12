module MinceMigrator
  module Migrations
    require_relative 'template'
    require_relative '../config'
    require_relative 'versioned_file'

    class File
      attr_reader :name

      def initialize(name)
        @original_name = name
        @version = 1
        self.name = name
      end

      def full_relative_path
        ::File.join(Config.migration_relative_dir, filename)
      end

      def name=(val)
        @name = val.gsub(" ", "_").downcase
      end

      def filename
        "#{name}.rb"
      end

      def full_path
        ::File.join Config.migration_dir, filename
      end

      def klass_name
        name.split("_").map{|a| a.capitalize }.join
      end

      def klass
        eval "::MinceMigrator::Migrations::#{klass_name}"
      end

      def body
        @body ||= Template.new(klass_name).render
      end

      def persisted?
        ::File.exists?(full_path)
      end

      def load
        require full_path
      end

      def self.load_from_file(path_to_file)
        new(path_to_file.split("/")[-1].gsub('.rb', '')).tap(&:load)
      end

      def self.find(name)
        file = new(name)
        file if file.persisted?
      end
    end
  end
end

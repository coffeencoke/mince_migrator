module MinceMigrator
  module Migrations
    require_relative 'template'
    require_relative '../config'
    require_relative 'versioned_file'
    require_relative 'loader'

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
        name.split("_").map(&:capitalize).join
      end

      def klass
        loader.klass
      end

      def body
        @body ||= Template.new(klass_name).render
      end

      def persisted?
        ::File.exists?(full_path)
      end

      def load
        loader.call
      end

      def self.load_from_file(path_to_file)
        name = convert_path_to_name(path_to_file)
        find(name)
      end

      def self.find(name)
        file = new(name)
        file.tap(&:load) if file.persisted?
      end

      def self.convert_path_to_name(path)
        path.split("/")[-1].gsub('.rb', '')
      end

      private

      def loader
        @loader ||= Loader.new(full_path: full_path, klass_name: klass_name)
      end
    end
  end
end

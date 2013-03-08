module MinceMigrator
  module Migrations
    require_relative 'template'
    require_relative '../config'

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
        if ::File.exists?(full_path)
          @version += 1
          self.name = "#{@original_name}_#{@version}"
        end
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

      def body
        @body ||= Template.new(klass_name).render
      end
    end
  end
end

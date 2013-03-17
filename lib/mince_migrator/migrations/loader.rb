module MinceMigrator
  module Migrations
    class Loader
      def initialize(options)
        @klass_name = options[:klass_name]
        @full_path = options[:full_path]
      end

      def klass
        eval "::MinceMigrator::Migrations::#{@klass_name}"
      end

      def call
        check_that_file_exists
        require @full_path
        klass
      rescue NameError
        raise 'invalid migration'
      end

      private

      def check_that_file_exists
        if !::File.exists?(@full_path)
          raise 'migration does not exist'
        end
      end
    end
  end
end

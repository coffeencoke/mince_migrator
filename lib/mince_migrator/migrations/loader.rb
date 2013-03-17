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
        require @full_path
      end
    end
  end
end

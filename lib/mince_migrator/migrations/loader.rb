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
        if valid?
          require @full_path
          perform_post_load_validations
        end
      end

      def valid?
        file_exists?
      end

      private

      def perform_post_load_validations
        mince_migration? && has_valid_interface?
      end

      def mince_migration?
        klass # Check that constant is valid and loaded
      rescue NameError
        raise 'invalid migration'
      end

      def has_valid_interface?
        if !has_all_interfaces?
          raise "migration does not have all required methods (:run, :revert, and :time_created)"
        end
      end

      def has_all_interfaces?
        %w(run revert time_created).all?{|a| klass.respond_to?(a) }
      end

      def file_exists?
        raise 'migration does not exist' unless ::File.exists?(@full_path)
        true
      end
    end
  end
end

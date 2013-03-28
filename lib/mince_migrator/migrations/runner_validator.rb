module MinceMigrator
  module Migrations
    require_relative '../migration'
    require_relative 'runner_validator'
    require 'mince/config'

    class RunnerValidator
      attr_reader :migration, :errors

      def initialize(migration)
        @migration = migration
      end

      def call
        @errors = []
        run_validations
        errors.empty?
      end

      def run_validations
        validate_mince_interface
        validate_migration_exists
        validate_migration_not_ran
      end

      def validate_migration_not_ran
        @errors << "Migration has already ran" if interface_is_set? && migration_exists? && migration.ran?
      end

      def validate_migration_exists
        @errors << "Migration does not exist" if interface_is_set? && !migration_exists?
      end

      def migration_exists?
        !!migration
      end

      def validate_mince_interface
        @errors << "Mince interface is not set" unless interface_is_set?
      end

      def interface_is_set?
        !!Mince::Config.interface
      end
    end
  end
end

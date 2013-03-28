module MinceMigrator
  module Migrations
    require_relative '../migration'

    class Runner
      attr_reader :name, :errors

      def initialize(name)
        @name = name
        @errors = []
      end

      def can_run_migration?
        valid?
      end

      def run_migration
        migration.run
        RanMigration.create(name: migration.name)
        true
      end

      def reasons_for_failure
        valid?
        @errors.join(" ")
      end

      def migration
        @migration||= Migration.find(name)
      end

      def valid?
        @errors = []
        run_validations
        errors.empty?
      end

      def run_validations
        validate_migration_exists
        validate_migration_not_ran
      end

      def validate_migration_not_ran
        @errors << "Migration has already ran" if migration_exists? && migration.ran?
      end

      def validate_migration_exists
        @errors << "Migration does not exist" unless migration_exists?
      end

      def migration_exists?
        !!migration
      end
    end
  end
end

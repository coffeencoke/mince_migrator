module MinceMigrator
  module Migrations
    require_relative '../migration'
    require_relative 'runner_validator'
    require 'mince/config'

    class Runner
      attr_reader :name, :validator

      def initialize(options)
        if options[:migration]
          @migration = options[:migration]
          @name = migration.name
        elsif options[:name]
          @name = options[:name]
        end
        @validator = RunnerValidator.new(migration)
      end

      def can_run_migration?
        validator.call
      end

      def run_migration
        migration.run
        RanMigration.create(name: migration.name)
        true
      end

      def reasons_for_failure
        validator.errors.join(" ")
      end

      def migration
        @migration ||= Migration.find(name)
      end
    end
  end
end

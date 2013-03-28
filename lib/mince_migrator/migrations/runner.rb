module MinceMigrator
  module Migrations
    require_relative '../migration'

    class Runner
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def can_run_migration?
        !!migration
      end

      def run_migration
        migration.run
      end

      def reasons_for_failure
        if !can_run_migration?
          "Migration does not exist"
        end
      end

      def migration
        @migration||= Migration.find(name)
      end
    end
  end
end

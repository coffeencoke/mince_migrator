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

      end

      def reasons_for_failure
        ""
      end

      def migration
        @migration||= Migration.find(name)
      end
    end
  end
end
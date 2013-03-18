module MinceMigrator
  module Migrations
    class Runner
      def initialize(name)

      end

      def can_run_migration?
        true
      end

      def run_migration

      end

      def reasons_for_failure
        ""
      end
    end
  end
end

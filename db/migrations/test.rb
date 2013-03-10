module MinceMigrator
  module Migrations
    module Test
      def self.run
        # Actual migration goes here
      end

      def self.revert
        # In case you need to revert this one migration
      end

      # So you can change the order to run more easily
      def self.time_created
        "2013-03-10 04:18:11 UTC"
      end

      module Temporary
        # Migration dependent classes go here
      end
    end
  end
end

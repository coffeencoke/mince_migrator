module MinceMigrator
  module Migrations
    require 'time'

    module TestMigration
      def self.run
        test_file = ::File.expand_path '../../../tmp/test_migration_file.txt', __FILE__
        FileUtils.touch test_file
        "Returning a value as a result of the run method"
      end

      def self.revert
        "Returning a value as a result of the revert method"
      end

      # So you can change the order to run more easily
      def self.time_created
        Time.parse '2013-03-04 09:31:28 UTC'
      end

      module Temporary
        # Migration dependent classes go here
      end
    end
  end
end


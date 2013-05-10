module MinceMigrator
  module Migrations
    require 'time'

    module TestMigration
      def self.run
        Temporary::UserDataModel.add(username: 'matt')
      end

      def self.revert
        Temporary::UserDataModel.delete_by_params(username: 'matt')
      end

      # So you can change the order to run more easily
      def self.time_created
        Time.parse '2013-03-04 09:31:28 UTC'
      end

      module Temporary
        class UserDataModel
          include Mince::DataModel

          data_collection :users
          data_fields :username, :email, :first_name, :last_name
        end
      end
    end
  end
end


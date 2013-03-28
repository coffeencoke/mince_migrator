require_relative '../lib/mince_migrator'
require_relative '../lib/mince_migrator/config'
require 'mince'
require 'hashy_db'

Mince::Config.interface = Mince::HashyDb::Interface
MinceMigrator::Config.instance.migration_relative_dir = "tmp/db_for_integration_specs"

RSpec.configure do |config|
  config.after(:each) do
    if File.exists?(MinceMigrator::Config.migration_dir)
      FileUtils.rm_r MinceMigrator::Config.migration_dir
    end

    Mince::Config.interface.clear
  end
end

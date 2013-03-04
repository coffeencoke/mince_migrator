require_relative '../../lib/mince_migrator'

require 'hashy_db'

Mince::Config.interface = Mince::HashyDb::Interface

describe "The creation of a migration:" do
  subject { MinceMigrator::Creator.new options }

  after do
    Mince::Config.interface.clear
  end

  describe "Attempting to create a migration without a name" do
    let(:options) { nil }

    it "returns reasons why a migration could not be created" do
      subject.can_create_migration?.should be_false
    end
  end

  describe "Creating a mince migration with a name" do
    let(:options) { "Create seeded admin users" }

    it "can create the migration" do
      subject.can_create_migration?.should be_true
    end

    it "creates the migration file" do
      subject.create_migration

      relative_path = Dir.pwd
      expected_migration_file_destination = File.join(relative_path, "db", "migrations", "create_seeded_admin_users.rb")
      File.open(expected_migration_file_destination, 'r') do |f|
        f.read.should == "Haz content"
      end

      # teardown
      FileUtils.rm expected_migration_file_destination
    end
  end
end

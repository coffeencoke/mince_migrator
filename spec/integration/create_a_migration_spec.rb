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

    it "returns the migration that was created" do
      subject.can_create_migration?.should be_true
    end
  end
end

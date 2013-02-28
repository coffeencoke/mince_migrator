require_relative '../../lib/mince_migrator'

require 'hashy_db'

Mince::Config.interface = Mince::HashyDb::Interface

describe "The creation of a migration:" do
  before do
  end

  after do
    Mince::Config.interface.clear
  end

  describe "Attempting to create a migration without a name" do
    it "returns reasons why a migration could not be created"
  end

  describe "Creating a mince migration with a name" do
    it "returns the migration that was created"
  end
end

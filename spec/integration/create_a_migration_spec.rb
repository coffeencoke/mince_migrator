require_relative '../integration_helper'

describe "The creation of a migration:" do
  subject { MinceMigrator::Creator.new name }

  context "when a name is not provided" do
    let(:name) { nil }

    it "returns reasons why a migration could not be created" do
      subject.can_create_migration?.should be_false
    end
  end

  describe "Creating a mince migration with a name" do
    let(:name) { "Create seeded admin users" }

    it "can create the migration" do
      subject.can_create_migration?.should be_true
    end

    it "creates the migration file" do
      subject.create_migration

      relative_path = Dir.pwd
      expected_migration_file_destination = ::File.join(MinceMigrator::Config.migration_dir, "create_seeded_admin_users.rb")
      ::File.open(expected_migration_file_destination, 'r') do |f|
        expected_content = <<-eos
module MinceMigrator
  module Migrations
    require 'time'

    module CreateSeededAdminUsers
      def self.run
        # Actual migration goes here
      end

      def self.revert
        # In case you need to revert this one migration
      end

      # So you can change the order to run more easily
      def self.time_created
        Time.parse "#{Time.now.utc.to_s}"
      end

      module Temporary
        # Migration dependent classes go here
      end
    end
  end
end
eos
        f.read.should == expected_content
      end
    end
  end
end

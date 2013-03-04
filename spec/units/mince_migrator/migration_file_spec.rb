require_relative '../../../lib/mince_migrator/migration_file'

describe MinceMigrator::MigrationFile do
  subject { described_class.new(name) }
  let(:name) { "Change spaces to underscores" }
  let(:now) { mock 'time', to_s: "2013-02-23 19:03:27 UTC" }

  before do
    Time.stub_chain('now.utc' => now)
  end

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(subject.path, subject.filename) }
  its(:path) { should == File.join(Dir.pwd, "db", "migrations") }
  it 'has a body using the migraiton template' do 
    expected_content = <<-eos
module MinceMigrator
  module Migrations
    module ChangeSpacesToUnderscores
      def self.run
        # Actual migration goes here
      end

      def self.revert
        # In case you need to revert this one migration
      end

      # So you can change the order to run more easily
      def self.time_created
        "#{now.to_s}"
      end

      module Temporary
        # Migration dependent classes go here
      end
    end
  end
end
eos
    subject.body.should == expected_content
  end
end

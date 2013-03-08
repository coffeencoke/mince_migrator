require_relative '../../../lib/mince_migrator/migration_template'

describe MinceMigrator::MigrationTemplate do
  subject { described_class.new klass_name }

  let(:klass_name) { 'NameOfMigration' }
  let(:now) { mock 'time', to_s: "2013-02-23 19:03:27 UTC" }

  before do
    Time.stub_chain('now.utc' => now)
  end

  it 'renders the template' do
    expected_content = <<-eos
module MinceMigrator
  module Migrations
    module #{klass_name}
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
    subject.render.should == expected_content
  end
end

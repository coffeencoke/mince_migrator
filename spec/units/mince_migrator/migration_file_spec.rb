require_relative '../../../lib/mince_migrator/migration_file'

describe MinceMigrator::MigrationFile do
  subject { described_class.new(name) }
  let(:name) { "Change spaces to underscores" }

  its(:name) { should == "change_spaces_to_underscores" }

  its(:path) { should == "/tmp/#{subject.name}.rb" }
end

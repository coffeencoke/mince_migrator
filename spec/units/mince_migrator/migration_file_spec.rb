require_relative '../../../lib/mince_migrator/migration_file'

describe MinceMigrator::MigrationFile do
  subject { described_class.new(name) }
  let(:name) { "Change spaces to underscores" }

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(subject.path, subject.filename) }
  its(:path) { should == File.join(Dir.pwd, "db", "migrations") }
end

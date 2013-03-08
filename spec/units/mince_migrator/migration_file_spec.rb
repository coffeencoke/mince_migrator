require_relative '../../../lib/mince_migrator/migration_file'

describe MinceMigrator::MigrationFile do
  subject { described_class.new(name) }

  let(:expected_class_name) { 'ChangeSpacesToUnderscores' }
  let(:name) { "Change spaces to underscores" }
  let(:migration_template) { mock render: mock }

  before do
    MinceMigrator::MigrationTemplate.stub(:new).with(expected_class_name).and_return(migration_template)
  end

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(subject.path, subject.filename) }
  its(:full_relative_path) { should == File.join(subject.relative_path, subject.filename) }
  its(:relative_path) { should == "db/migrations" }
  its(:path) { should == File.join(Dir.pwd, "db", "migrations") }
  its(:body) { should == migration_template.render }
end

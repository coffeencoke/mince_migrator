require_relative '../../../../lib/mince_migrator/migrations/file'

describe MinceMigrator::Migrations::File do
  subject { described_class.new(name) }

  let(:expected_class_name) { 'ChangeSpacesToUnderscores' }
  let(:name) { "Change spaces to underscores" }
  let(:migration_template) { mock render: mock }
  let(:config) { MinceMigrator::Config }

  before do
    MinceMigrator::Migrations::Template.stub(:new).with(expected_class_name).and_return(migration_template)
    File.stub(:exists?).with(subject.full_path).and_return(false)
  end

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(config.migration_dir, subject.filename) }
  its(:full_relative_path) { should == File.join(config.migration_relative_dir, subject.filename) }
  its(:body) { should == migration_template.render }

  context 'when it has been written to the file system' do
    before do
      ::File.stub(:exists?).with(subject.full_path).and_return(true)
    end

    its(:persisted?) { should be_true }
  end

  context 'when it has not been written to the file system' do
    before do
      ::File.stub(:exists?).with(subject.full_path).and_return(false)
    end

    its(:persisted?) { should be_false }
  end
end

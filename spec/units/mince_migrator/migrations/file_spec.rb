require_relative '../../../../lib/mince_migrator/migrations/file'

describe MinceMigrator::Migrations::File do
  subject { described_class.new(name) }

  let(:expected_class_name) { 'ChangeSpacesToUnderscores' }
  let(:name) { "Change spaces to underscores" }
  let(:migration_template) { mock render: mock }
  let(:config) { MinceMigrator::Config }
  let(:loader) { mock klass: mock, load: nil }

  before do
    MinceMigrator::Migrations::Template.stub(:new).with(expected_class_name).and_return(migration_template)
    File.stub(:exists?).with(subject.full_path).and_return(false)
    MinceMigrator::Migrations::Loader.stub(:new).with(full_path: subject.full_path, klass_name: subject.klass_name).and_return(loader)
  end

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(config.migration_dir, subject.filename) }
  its(:full_relative_path) { should == File.join(config.migration_relative_dir, subject.filename) }
  its(:body) { should == migration_template.render }
  its(:klass) { should == loader.klass }

  it 'can load the migration file' do
    loader.should_receive(:call)

    subject.load
  end

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

describe MinceMigrator::Migrations::File, 'Class methods:' do
  describe 'finding a file' do
    subject { described_class.find(name) }

    let(:name) { mock }
    let(:file) { mock }

    before do
      described_class.stub(:new).with(name).and_return(file)
    end

    context 'when one exists' do
      before do
        file.stub(persisted?: true, load: nil)
      end

      it 'returns the file' do
        subject.should == file
      end

      it 'loads the migration class' do
        file.should_receive(:load)

        subject
      end
    end

    context 'when one does not exist' do
      before do
        file.stub(persisted?: false)
      end

      it 'returns nothing' do
        subject.should be_nil
      end
    end
  end
end

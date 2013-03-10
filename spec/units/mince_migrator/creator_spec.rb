require_relative '../../../lib/mince_migrator/creator'

describe MinceMigrator::Creator do
  context 'when a name is not provided' do
    it 'cannot create the migration' do
      subject.can_create_migration?.should be_false
    end
  end

  context 'when a name is provided' do
    subject { described_class.new(migration_name) }

    let(:migration_name) { mock }
    let(:opened_file) { mock write: nil, close: nil }
    let(:migration_file) { mock path: mock, full_path: mock, body: mock, full_relative_path: mock }
    let(:versioned_file) { mock next_unused_version: migration_file }

    before do
      FileUtils.stub(:mkdir_p).with(MinceMigrator::Config.migration_dir)
    end

    context 'when no migrations exist with this name' do
      before do
        MinceMigrator::Migrations::VersionedFile.stub(:new).with(migration_name).and_return(versioned_file)
        ::File.stub(:open).with(migration_file.full_path, 'w+').and_return(opened_file)
        ::File.stub(:exists?).with(migration_file.full_path).and_return(false)
      end

      its(:migration_file_relative_path){ should == migration_file.full_relative_path }

      it 'insures the path to the migraiton file exists' do
        FileUtils.should_receive(:mkdir_p).with(MinceMigrator::Config.migration_dir)

        subject.create_migration
      end

      it 'can create the migration' do
        subject.can_create_migration?.should be_true
      end

      it 'creates a migration file' do
        opened_file.should_receive(:write).with(migration_file.body)
        opened_file.should_receive(:close)

        subject.create_migration
      end
    end
  end
end

describe MinceMigrator::Creator, 'Class level methods' do
  it 'can create a migration' do
    name = mock
    creator = mock can_create_migration?: true
    described_class.should_receive(:new).with(name).and_return(creator)
    creator.should_receive(:create_migration)

    described_class.create(name)
  end
end

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
    let(:migration_file) { mock path: mock, full_path: mock, body: mock, full_relative_path: mock }
    let(:opened_file) { mock }

    before do
      FileUtils.stub(:mkdir_p).with(MinceMigrator::Config.migration_dir)
      MinceMigrator::Migrations::File.stub(:new).with(migration_name).and_return(migration_file)
      File.stub(:open).with(migration_file.full_path, 'w+').and_return(opened_file)
      opened_file.stub(write: nil, close: nil)
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

describe MinceMigrator::Creator, 'Class level methods' do
  it 'can create a migration' do
    name = mock
    creator = mock can_create_migration?: true
    described_class.should_receive(:new).with(name).and_return(creator)
    creator.should_receive(:create_migration)

    described_class.create(name)
  end
end

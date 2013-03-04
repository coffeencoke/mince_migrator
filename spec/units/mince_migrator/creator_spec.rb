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
    let(:migration_file) { mock path: mock, full_path: mock }

    before do
      FileUtils.stub(:mkdir_p).with(migration_file.path)
      MinceMigrator::MigrationFile.stub(:new).with(migration_name).and_return(migration_file)
      File.stub(:open).with(migration_file.full_path, 'w+')
    end

    it 'insures the path to the migraiton file exists' do
      FileUtils.should_receive(:mkdir_p).with(migration_file.path)

      subject.create_migration
    end

    it 'can create the migration' do
      subject.can_create_migration?.should be_true
    end

    it 'creates a migration file' do
      File.should_receive(:open).with(migration_file.full_path, 'w+')

      subject.create_migration
    end
  end
end

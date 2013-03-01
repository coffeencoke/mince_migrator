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
    let(:migration_file) { mock path: migration_file_path }
    let(:migration_file_path) { mock }

    before do
      MinceMigrator::MigrationFile.stub(:new).with(migration_name).and_return(migration_file)
    end

    it 'can create the migration' do
      subject.can_create_migration?.should be_true
    end

    it 'creates a migration file' do
      File.should_receive(:open).with(migration_file_path, 'w+')

      subject.create_migration
    end
  end
end

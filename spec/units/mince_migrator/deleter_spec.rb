require_relative '../../../lib/mince_migrator/deleter'

describe MinceMigrator::Deleter do
  let(:name) { mock }
  let(:migration_name) { mock filename: mock }
  let(:migration_path) { ::File.join(path, migration_name.filename) }
  let(:path) { mock }
  
  subject { described_class.new(name) }

  before do
    MinceMigrator::Config.stub(migration_dir: path)
    MinceMigrator::Migrations::Name.stub(:new).with(name).and_return(migration_name)
  end

  context 'when the migration does not exist' do
    before do
      ::File.stub(:exists?).with(migration_path).and_return(false)
    end

    its(:can_delete_migration?) { should be_false }
  end

  context 'when the migration exists' do
    before do
      ::File.stub(:exists?).with(migration_path).and_return(true)
    end

    its(:can_delete_migration?) { should be_true }

    it 'deletes the migration' do
      FileUtils.should_receive(:rm).with(migration_path)

      subject.delete_migration
    end
  end
end

require_relative '../../../lib/mince_migrator/deleter'

describe MinceMigrator::Deleter do
  let(:name) { mock }
  let(:migration_name) { mock filename: mock, value: mock }
  let(:migration_path) { ::File.join(path, migration_name.filename) }
  let(:path) { mock }
  
  subject { described_class.new(name: name) }

  before do
    MinceMigrator::Config.stub(migration_dir: path)
    MinceMigrator::Migrations::Name.stub(:new).with(name).and_return(migration_name)
  end

  context 'when the migration does not exist' do
    before do
      ::File.stub(:exists?).with(migration_path).and_return(false)
    end

    its(:can_delete_migration?) { should be_false }
    its(:reasons_for_failure) { should == "Migration does not exist with name '#{migration_name.value}'" }
  end

  context 'when the migration exists' do
    let(:ran_migration) { nil }

    before do
      ::File.stub(:exists?).with(migration_path).and_return(true)
      MinceMigrator::RanMigration.stub(:find_by_name).with(migration_name.value).and_return(ran_migration)
      FileUtils.stub(:rm)
    end

    its(:can_delete_migration?) { should be_true }

    it 'deletes the migration' do
      FileUtils.should_receive(:rm).with(migration_path)

      subject.delete_migration
    end

    context 'when it has been ran' do
      let(:ran_migration) { mock }

      it 'deletes the migration for the database' do
        ran_migration.should_receive(:delete)

        subject.delete_migration
      end
    end
  end
end

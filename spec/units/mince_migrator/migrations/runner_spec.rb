require_relative '../../../../lib/mince_migrator/migrations/runner'

describe MinceMigrator::Migrations::Runner do
  subject { described_class.new(name) }

  let(:name) { mock }

  before do
    Mince::Config.interface = mock
  end

  context 'when the migration exists' do
    let(:migration) { mock ran?: false, name: mock }

    before do
      MinceMigrator::Migration.stub(:find).with(name).and_return(migration)
    end

    its(:can_run_migration?) { should be_true }

    context 'when it is ran' do
      before do
        migration.stub(:run)
        MinceMigrator::RanMigration.stub(:create)
      end

      it 'returns true' do
        subject.run_migration.should be_true
      end

      it 'runs the migration' do
        migration.should_receive(:run)

        subject.run_migration
      end

      it 'stores the record that it has been ran' do
        MinceMigrator::RanMigration.should_receive(:create).with(name: migration.name)

        subject.run_migration
      end
    end

    context 'when it has already ran' do
      before do
        migration.stub(ran?: true)
      end

      its(:can_run_migration?) { should be_false }
      its(:reasons_for_failure) { should == 'Migration has already ran' }
    end
  end

  context 'when the migration does not exist' do
    before do
      MinceMigrator::Migration.stub(:find).with(name).and_return(nil)
    end

    its(:can_run_migration?) { should be_false }
    its(:reasons_for_failure) { should == 'Migration does not exist' }
  end

  context 'when the mince interface is not set' do
    let(:name) { 'name' }

    before do
      Mince::Config.interface = nil
    end

    its(:can_run_migration?) { should be_false }
    its(:reasons_for_failure) { should == 'Mince interface is not set' }
  end
end

require_relative '../../../lib/mince_migrator/reverter'

describe MinceMigrator::Reverter do
  subject { described_class.new(name: name) }

  let(:name) { mock }
  let(:migration_name) { mock value: mock }

  before do
    MinceMigrator::Migrations::Name.stub(:new).with(name).and_return(migration_name)
  end

  describe 'initializing with a migration' do
    subject { described_class.new(migration: migration) }

    let(:migration) { mock name: name }

    its(:migration) { should == migration }
    its(:name) { should == migration_name.value }
  end

  context 'when the migration does not exist' do
    before do
      MinceMigrator::Migration.stub(:find).with(migration_name.value).and_return(nil)
      subject.can_revert_migration?
    end

    its(:can_revert_migration?) { should be_false }
    its(:reasons_for_failure) { should == "Migration does not exist with name '#{migration_name.value}'" }
  end

  context 'when the migration exists' do
    let(:migration) { mock name: mock }

    before do
      MinceMigrator::Migration.stub(:find).with(migration_name.value).and_return(migration)
    end

    context 'and has been ran' do
      let(:ran_migration) { mock }

      before do
        migration.stub(ran?: true, ran_migration: ran_migration)
        migration.stub(:revert)
        ran_migration.stub(:delete)
      end

      its(:can_revert_migration?) { should be_true }

      it 'returns true' do
        subject.revert_migration.should be_true
      end

      it 'reverts the migration' do
        migration.should_receive(:revert)

        subject.revert_migration
      end

      it 'deletes the ran migration' do
        ran_migration.should_receive(:delete)

        subject.revert_migration
      end
    end

    context 'but has not been ran' do
      before do
        migration.stub(ran?: false)

        subject.can_revert_migration?
      end

      its(:can_revert_migration?) { should be_false }
      its(:reasons_for_failure) { should == "Migration has not ran" }
    end
  end
end

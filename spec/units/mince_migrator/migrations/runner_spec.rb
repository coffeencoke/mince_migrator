require_relative '../../../../lib/mince_migrator/migrations/runner'

describe MinceMigrator::Migrations::Runner do
  subject { described_class.new(name: name) }

  let(:name) { mock }
  let(:validator) { mock }

  before do
    Mince::Config.interface = mock
  end

  describe 'initializing with a migration' do
    subject { described_class.new(migration: migration) }

    let(:migration) { mock name: 'asdf' }

    its(:migration) { should == migration }
    its(:name) { should == migration.name }
  end

  context 'when the migration exists' do
    let(:migration) { mock ran?: false, name: mock }

    before do
      MinceMigrator::Migrations::RunnerValidator.stub(:new).with(migration).and_return(validator)
      MinceMigrator::Migration.stub(:find).with(name).and_return(migration)
      validator.stub(call: true, errors: [])
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
  end

  context 'when the runner validator has errors' do
    let(:errors) { [mock] }
    let(:name) { mock }

    before do
      MinceMigrator::Migrations::RunnerValidator.stub(:new).with(nil).and_return(validator)
      validator.stub(call: false, errors: errors)
      MinceMigrator::Migration.stub(:find).with(name).and_return(nil)
    end

    its(:can_run_migration?) { should be_false }
    its(:reasons_for_failure) { should == errors.join(' ') }
  end
end

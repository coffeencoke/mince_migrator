require_relative '../../../../lib/mince_migrator/migrations/runner'

describe MinceMigrator::Migrations::Runner do
  subject { described_class.new(name) }

  let(:name) { mock }

  context 'when the migration exists' do
    let(:migration) { mock }

    before do
      MinceMigrator::Migration.stub(:find).with(name).and_return(migration)
    end

    its(:can_run_migration?) { should be_true }
  end

  context 'when the migration does not exist' do
    before do
      MinceMigrator::Migration.stub(:find).with(name).and_return(nil)
    end

    its(:can_run_migration?) { should be_false }
  end
end

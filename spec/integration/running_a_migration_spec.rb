require_relative '../integration_helper'

describe 'Running a migration' do
  subject { MinceMigrator::Migrations::Runner.new(name) }

  pending 'when the migration could not be found' do
    let(:name) { mock 'migration that does not exist' }

    its(:reasons_for_failure) { should == "Migration does not exist" }
    its(:can_run_migration?) { should be_false }
  end

  context 'when the migration exists' do
    let(:name) { "test migration" }

    its(:reasons_for_failure) { should be_empty }
    its(:can_run_migration?) { should be_true }

    it 'can run the migration'
  end
end

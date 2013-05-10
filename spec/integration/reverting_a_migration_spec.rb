require_relative '../integration_helper'

describe 'Reverting a migration' do
  subject { MinceMigrator::Reverter.new(name: name) }

  let(:name) { 'name of migration' }
  let(:expected_name) { 'Name of migration' }

  context 'when the migration exists' do
    let(:name) { "test migration" }
    let(:spec_migration) { File.expand_path('../../support/test_migration.rb', __FILE__) }
    let(:db_dir) { MinceMigrator::Config.migration_dir }
    let(:data_model) { MinceMigrator::Migrations::TestMigration::Temporary::UserDataModel }

    before do
      FileUtils.mkdir_p(db_dir)
      FileUtils.cp(spec_migration, db_dir)
    end

    context 'and the migration has not yet been ran' do
      before do
        subject.can_revert_migration?
      end

      its(:reasons_for_failure) { should == "Migration has not ran" }
      its(:can_revert_migration?) { should be_false }
    end

    context 'when the migration has ran' do
      before do
        MinceMigrator::Migrations::Runner.new(name: name).run_migration
      end

      its(:can_revert_migration?) { should be_true }
      its(:reasons_for_failure) { should be_empty }

      it 'reverts the migration' do
        subject.revert_migration

        data_model.all.size.should == 0
      end

      it 'reverts it from the database' do
        subject.revert_migration

        MinceMigrator::RanMigration.all.should be_empty
      end
    end
  end

  context 'when the migration does not exist' do
    before do
      subject.can_revert_migration?
    end

    its(:can_revert_migration?) { should be_false }
    its(:reasons_for_failure) { should == "Migration does not exist with name '#{expected_name}'" }
  end
end

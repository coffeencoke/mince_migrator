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
    let(:spec_migration) { File.expand_path('../../support/test_migration.rb', __FILE__) }
    let(:db_dir) { MinceMigrator::Config.migration_dir }
    let(:data_model) { MinceMigrator::Migrations::TestMigration::Temporary::UserDataModel }

    its(:reasons_for_failure) { should be_empty }
    its(:can_run_migration?) { should be_true }

    before do
      FileUtils.mkdir_p(db_dir)
      FileUtils.cp(spec_migration, db_dir)
    end

    it 'can run the migration' do
      subject.run_migration.should be_true

      users = data_model.all
      users.size.should == 1
      users.first[:username].should == 'matt'
    end
  end
end

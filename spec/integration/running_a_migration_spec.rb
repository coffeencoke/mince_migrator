require_relative '../integration_helper'

describe 'Running a migration' do
  subject { MinceMigrator::Migrations::Runner.new(name: name) }

  context 'when the migration could not be found' do
    let(:name) { 'migration that does not exist' }

    before do
      subject.can_run_migration?
    end

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
      subject.can_run_migration?
    end

    it 'can run the migration' do
      subject.run_migration.should be_true

      users = data_model.all
      users.size.should == 1
      users.first[:username].should == 'matt'
    end

    context 'and the migration has already been ran' do
      before do
        subject.run_migration
        subject.can_run_migration?
      end
  
      its(:reasons_for_failure) { should == "Migration has already ran" }
      its(:can_run_migration?) { should be_false }
    end
  end

  context 'when Mince interface has not been set' do
    let(:name) { 'name' }

    before do
      Mince::Config.interface = nil
      subject.can_run_migration?
    end

    after do
      Mince::Config.interface = Mince::HashyDb::Interface
    end

    its(:reasons_for_failure) { should == "Mince interface is not set" }
    its(:can_run_migration?) { should be_false }
  end
end

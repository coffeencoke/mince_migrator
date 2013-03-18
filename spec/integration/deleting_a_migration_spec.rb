require_relative '../integration_helper'

describe 'Deleting a migration' do
  subject { MinceMigrator::Deleter.new(name) }

  let(:name) { 'name of migration' }

  context 'when the migration exists' do
    before do
      MinceMigrator::Creator.create(name)
    end

    its(:can_delete_migration?) { should be_true }

    it 'deletes it from the file system' do
      expected_migration_destination = ::File.join(MinceMigrator::Config.migration_dir, 'name_of_migration.rb')
      subject.delete_migration

      ::File.exists?(expected_migration_destination).should be_false
    end
  end

  context 'when the migration does not exist' do
    its(:can_delete_migration?) { should be_false }
  end
end

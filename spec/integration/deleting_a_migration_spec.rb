require_relative '../../lib/mince_migrator'

describe 'Deleting a migration' do
  subject { MinceMigrator::Deleter.new(name) }

  let(:name) { 'name of migration' }

  context 'when the migration exists' do
    it 'deletes it from the file system'
  end

  context 'when the migration does not exist' do
    before do
      MinceMigrator::Creator.create(name)
    end

    after do
      relative_path = Dir.pwd
      expected_migration_file_destination = File.join(relative_path, "db", "migrations", "name_of_migration.rb")
      FileUtils.rm expected_migration_file_destination
    end

    its(:can_delete_migration?) { should be_false }
  end
end

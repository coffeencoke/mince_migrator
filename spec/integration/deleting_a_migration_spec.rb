require_relative '../../lib/mince_migrator'

describe 'Deleting a migration' do
  subject { MinceMigrator::Deleter.new(name) }

  let(:name) { 'name of migration' }

  context 'when the migration exists' do
    before do
      MinceMigrator::Creator.create(name)
    end

    its(:can_delete_migration?) { should be_true }

    it 'deletes it from the file system'
  end

  context 'when the migration does not exist' do
    its(:can_delete_migration?) { should be_false }
  end
end

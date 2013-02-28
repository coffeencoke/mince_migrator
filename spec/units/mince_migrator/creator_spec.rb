require_relative '../../../lib/mince_migrator/creator'

describe MinceMigrator::Creator do
  context 'when a name is not provided' do
    it 'cannot create the migration' do
      subject.can_create_migration?.should be_false
    end
  end
end

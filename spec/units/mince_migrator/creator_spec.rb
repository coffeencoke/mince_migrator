require_relative '../../../lib/mince_migrator/creator'

describe MinceMigrator::Creator do
  context 'when a name is not provided' do
    it 'cannot create the migration' do
      subject.can_create_migration?.should be_false
    end
  end

  context 'when a name is provided' do
    subject { described_class.new("This migration can do stuff") }

    it 'can create the migration' do
      subject.can_create_migration?.should be_true
    end
  end
end

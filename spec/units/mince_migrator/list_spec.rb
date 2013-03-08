require_relative '../../../lib/mince_migrator/list'

describe MinceMigrator::List do
  it 'is empty' do
    subject.all.should be_empty
  end
end

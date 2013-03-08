require_relative '../../lib/mince_migrator'

describe 'List of migrations' do
  subject { MinceMigrator::List.new }

  context 'when there are not any migrations' do
    it 'is empty' do
      subject.all.should be_empty
    end
  end
end

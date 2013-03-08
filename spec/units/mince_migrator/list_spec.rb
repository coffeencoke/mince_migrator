require_relative '../../../lib/mince_migrator/list'

describe MinceMigrator::List do
  context 'when there are no migrations' do
    it 'is empty' do
      subject.all.should be_empty
    end

    its(:number_of_migrations) { should == 0 }
  end

  context 'when some migrations exist' do
    
  end
end

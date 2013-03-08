require_relative '../../lib/mince_migrator'

describe 'List of migrations' do
  subject { MinceMigrator::List.new }

  context 'when there are not any migrations' do
    its(:number_of_migrations) { should == 0 }

    it 'is empty' do
      subject.all.should be_empty
    end
  end

  context 'when there are some migrations' do
    let(:migration_1_name) { "first migration" }
    let(:migration_2_name) { "second migration" }
    let(:migration_1) { MinceMigrator::Migration.find(migration_1_name) }
    let(:migration_2) { MinceMigrator::Migration.find(migration_2_name) }

    before do
      MinceMigrator::Creator.create(migration_1_name)
      MinceMigrator::Creator.create(migration_2_name)
    end

    its(:number_of_migrations) { should == 2 }

    pending 'contains a record of those migrations' do
      subject.all.size.should == 2
      subject.all[0].should == migration_1
      subject.all[1].should == migration_2
    end
  end
end

require_relative '../../../lib/mince_migrator/list'

describe MinceMigrator::List do
  let(:migration_dir) { mock }

  before do
    MinceMigrator::Config.stub(migration_dir: migration_dir)
  end

  context 'getting all migrations' do
    context 'when there are no migrations' do
      before do
        Dir.stub(:glob).with("#{migration_dir}/*").and_return([])
      end

      it 'is empty' do
        subject.all.should be_empty
      end

      its(:number_of_migrations) { should == 0 }
    end

    context 'when some migrations exist' do
      let(:migration_paths) { [migration_path1, migration_path2] }
      let(:migration_path1) { mock }
      let(:migration_path2) { mock }
      let(:migration1) { mock time_created: Time.now.utc, status: 'ran' }
      let(:migration2) { mock time_created: Time.now.utc - 500000, status: 'not ran' }

      before do
        Dir.stub(:glob).with("#{migration_dir}/*").and_return(migration_paths)
        MinceMigrator::Migration.stub(:load_from_file).with(migration_path1).and_return(migration1)
        MinceMigrator::Migration.stub(:load_from_file).with(migration_path2).and_return(migration2)
      end

      its(:number_of_migrations) { should == 2 }

      it 'can load all migrations' do
        subject.all.should == [migration2, migration1]
      end

      context 'when only wanting a list of migrations that have not yet ran' do
        subject { described_class.new 'not ran' }

        its(:number_of_migrations) { should == 1 }

        it 'can load those migrations' do
          subject.all.should == [migration2]
        end
      end
    end
  end
end

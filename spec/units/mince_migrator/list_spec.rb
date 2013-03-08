require_relative '../../../lib/mince_migrator/list'

describe MinceMigrator::List do
  let(:migration_dir) { mock }

  before do
    MinceMigrator::Config.stub(migration_dir: migration_dir)
  end

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
    let(:file_paths) { [file_path1, file_path2] }
    let(:file_path1) { mock }
    let(:file_path2) { mock }

    before do
      Dir.stub(:glob).with("#{migration_dir}/*").and_return(file_paths)
    end

    its(:number_of_migrations) { should == 2 }
  end
end

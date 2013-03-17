require_relative '../../../lib/mince_migrator/migration'

require 'time'

describe MinceMigrator::Migration do
  subject { described_class.new(options) }

  let(:options) { { klass: klass, name: name, relative_path: relative_path, path: path } }
  let(:klass) { mock time_created: mock }
  let(:name) { "name_of_migration" }
  let(:relative_path) { mock }
  let(:path) { mock }

  its(:time_created) { should == klass.time_created }
  its(:relative_path) { should == relative_path }
  its(:path) { should == path }

  [
    { in: 'name', out: 'Name' }, 
    { in: 'name_of_migration', out: 'Name of migration' }, 
    { in: 'name of migration', out: 'Name of migration' },
    { in: 'Name Of Migration', out: 'Name of migration' }
  ].each do |name_group|
    context "when the name is '#{name_group[:in]}'" do
      let(:name) { name_group[:in] }

      its(:name) { should == name_group[:out] }
    end
  end
end

describe MinceMigrator::Migration, 'class methods:' do
  describe 'Loading from a file' do
    subject { described_class.load_from_file(path_to_file) }

    let(:path_to_file) { mock }
    let(:migration_file) { mock klass: mock, name: mock, full_relative_path: mock, full_path: mock }
    let(:migration) { mock }

    before do
      described_class.stub(:new).with(klass: migration_file.klass, name: migration_file.name, relative_path: migration_file.full_relative_path, path: migration_file.full_path).and_return(migration)
      MinceMigrator::Migrations::File.stub(:load_from_file).with(path_to_file).and_return(migration_file)
    end

    it 'returns a migration for the given migration file' do
      subject.should == migration
    end

    it 'loads the migration file into memory' do
      MinceMigrator::Migrations::File.should_receive(:load_from_file).with(path_to_file).and_return(migration_file)
     
      subject
    end
  end

  describe 'Finding a migration for a given name' do
    subject { described_class.find(name) }

    let(:name) { mock }

    context 'when the migration exists' do
      let(:migration) { mock }
      let(:migration_file) { mock }

      before do
        MinceMigrator::Migrations::File.stub(:find).with(name).and_return(migration_file)
        MinceMigrator::Migration.stub(:new_from_file).with(migration_file).and_return(migration)
      end

      it 'returns the migration' do
        subject.should == migration
      end
    end

    context 'when the migration does not exist' do
      before do
        MinceMigrator::Migrations::File.stub(:find).with(name).and_return(nil)
      end

      it 'returns nothing' do
        subject.should be_nil
      end
    end
  end

  describe 'initializing with a migration file' do
    subject { described_class.new_from_file(file) }

    let(:file) { mock klass: mock, name: mock, full_relative_path: mock, full_path: mock }
    let(:migration) { mock }

    before do
      described_class.stub(:new).with(klass: file.klass, name: file.name, relative_path: file.full_relative_path, path: file.full_path).and_return(migration)
    end

    it 'returns the migration' do
      subject.should == migration
    end
  end
end

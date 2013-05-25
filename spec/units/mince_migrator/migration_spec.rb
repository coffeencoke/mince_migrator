require_relative '../../../lib/mince_migrator/migration'

require 'time'

describe MinceMigrator::Migration do
  subject { described_class.new(options) }

  let(:options) { { klass: klass, name: name, relative_path: relative_path, path: path } }
  let(:klass) { mock time_created: Time.now.utc - 550000 }
  let(:name) { "name_of_migration" }
  let(:relative_path) { mock }
  let(:path) { mock }

  its(:time_created) { should == klass.time_created }
  its(:relative_path) { should == relative_path }
  its(:path) { should == path }
  its(:age) do 
    expected = if Time.now.utc.hour < 12
      should include '7d'
    else
      should include '6d'
    end
  end

  it 'can run the migration' do
    return_value = mock
    klass.should_receive(:run).and_return(return_value)
    subject.run.should == return_value
  end

  it 'can revert the migration' do
    return_value = mock
    klass.should_receive(:revert).and_return(return_value)
    subject.revert.should == return_value
  end

  context 'when there is a record of the migration being ran' do
    let(:ran_migration) { mock }

    before do
      MinceMigrator::RanMigration.stub(:find_by_name).with(subject.name).and_return(ran_migration)
    end

    its(:ran?) { should be_true }
    its(:status) { should == 'ran' }
  end

  context 'when there is not a record of the migration being ran' do
   before do
      MinceMigrator::RanMigration.stub(:find_by_name).with(subject.name).and_return(nil)
    end

    its(:ran?) { should be_false }
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

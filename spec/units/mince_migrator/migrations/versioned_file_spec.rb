require_relative '../../../../lib/mince_migrator/migrations/versioned_file'

describe MinceMigrator::Migrations::VersionedFile do
  describe 'Getting the next version of a migration for a given name' do
    subject { described_class.new(name).next_unused_version }

    let(:migration_file) { mock full_path: mock, persisted?: false }
    let(:name) { mock }

    context 'when no migrations contain the same name' do
      before do
        MinceMigrator::Migrations::File.stub(:new).with(name).and_return(migration_file)
      end

      it 'returns the migration file' do
        subject.should == migration_file
      end
    end

    context 'when a single migration exists with the same name' do
      let(:other_migration_file) { mock full_path: mock, persisted?: true }

      before do
        MinceMigrator::Migrations::File.stub(:new).with(name).and_return(other_migration_file)
        MinceMigrator::Migrations::File.stub(:new).with("#{name}_2").and_return(migration_file)
      end

      it 'returns a migration file the second version' do
        subject.should == migration_file
      end
    end

    context 'when multiple migrations exist with the same name' do
      let(:other_migration_file) { mock full_path: mock, persisted?: true }
      let(:other_migration_file2) { mock full_path: mock, persisted?: true }

      before do
        MinceMigrator::Migrations::File.stub(:new).with(name).and_return(other_migration_file)
        MinceMigrator::Migrations::File.stub(:new).with("#{name}_2").and_return(other_migration_file2)
        MinceMigrator::Migrations::File.stub(:new).with("#{name}_3").and_return(migration_file)
      end

      it 'returns a migration file for the first unused version' do
        subject.should == migration_file
      end
    end
  end
end

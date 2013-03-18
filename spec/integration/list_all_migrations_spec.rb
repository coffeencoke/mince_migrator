require_relative '../integration_helper'

describe 'List of migrations' do
  subject { MinceMigrator::List.new }

  context 'when there are not any migrations' do
    its(:number_of_migrations) { should == 0 }

    it 'is empty' do
      subject.all.should be_empty
    end
  end

  context 'when there is one migration' do
    let(:migration_name) { "first migration" }

    before do
      MinceMigrator::Creator.create(migration_name)
    end

    its(:number_of_migrations) { should == 1 }

    it 'contains a record of the migration' do
      subject.all.size.should == 1
      subject.all.first.name.should == "First migration"
      subject.all.first.status.should == 'not ran'
      subject.all.first.relative_path.should == File.join(MinceMigrator::Config.migration_relative_dir, 'first_migration.rb')
      subject.all.first.path.should == File.join(MinceMigrator::Config.migration_dir, 'first_migration.rb')
    end
  end

  context 'when there are some migrations' do
    let(:migration_1_name) { "first migration" }
    let(:migration_2_name) { "a second migration" }
    let(:migration_1) { MinceMigrator::Migration.find(migration_1_name) }
    let(:migration_2) { MinceMigrator::Migration.find(migration_2_name) }

    before do
      MinceMigrator::Creator.create(migration_1_name)
      MinceMigrator::Creator.create(migration_2_name)
    end

    its(:number_of_migrations) { should == 2 }

    it 'contains a record of those migrations' do
      expected_migrations = [migration_2, migration_1]
      subject.all.size.should == expected_migrations.size
      subject.all.each_with_index do |migration, index|
        expected_migration = expected_migrations.find{|a| a.name == migration.name }
        migration.name.should == expected_migration.name
        migration.status.should == 'not ran'
        migration.relative_path.should == migration.relative_path
        migration.path.should == migration.path
      end
    end
  end
end

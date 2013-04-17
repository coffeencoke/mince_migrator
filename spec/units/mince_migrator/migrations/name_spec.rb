require_relative '../../../../lib/mince_migrator/migrations/name'

module MinceMigrator
  module Migrations
    describe Name do
      subject { described_class.new(name) }

      invalid_names = [
        { in: '!@#$%^&*()', out: '' },
        { in: nil, out: nil },
        { in: '', out: '' }
      ]

      valid_names = [
        { in: 'name', out: 'Name', filename: 'name.rb' }, 
        { in: 'name_of_migration', out: 'Name of migration', filename: 'name_of_migration.rb' }, 
        { in: 'name of migration', out: 'Name of migration', filename: 'name_of_migration.rb' },
        { in: '1Name Of Migration', out: 'Name of migration', filename: 'name_of_migration.rb' },
        { in: 'Name Of Migration 1!@#$%^&*()', out: 'Name of migration 1', filename: 'name_of_migration_1.rb' }
      ]

      valid_names.each do |name_group|
        context "when the name is '#{name_group[:in]}'" do
          let(:name) { name_group[:in] }

          its(:value) { should == name_group[:out] }
          its(:filename) { should == name_group[:filename] }
          its(:valid?) { should be_true }
        end
      end

      invalid_names.each do |name_group|
        context "when the name is '#{name_group[:in]}'" do
          let(:name) { name_group[:in] }

          before do
            subject.valid?
          end

          its(:value) { should == name_group[:out] }
          its(:valid?) { should be_false }
          its(:reasons_for_failure) { should == "Name is invalid, it must start with a character from A-Z or a-z" }
        end
      end
    end
  end
end

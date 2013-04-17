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
        { in: 'name', out: 'Name' }, 
        { in: 'name_of_migration', out: 'Name of migration' }, 
        { in: 'name of migration', out: 'Name of migration' },
        { in: '1Name Of Migration', out: 'Name of migration' },
        { in: 'Name Of Migration 1!@#$%^&*()', out: 'Name of migration 1' }
      ]

      valid_names.each do |name_group|
        context "when the name is '#{name_group[:in]}'" do
          let(:name) { name_group[:in] }

          its(:value) { should == name_group[:out] }
          its(:valid?) { should be_true }
        end
      end

      invalid_names.each do |name_group|
        context "when the name is '#{name_group[:in]}'" do
          let(:name) { name_group[:in] }

          its(:value) { should == name_group[:out] }
          its(:valid?) { should be_false }
        end
      end
    end
  end
end

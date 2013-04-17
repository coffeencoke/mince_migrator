require_relative '../../../lib/mince_migrator/ran_migration'

describe MinceMigrator::RanMigration do
  let(:name) { "Name of migration" }
  
  subject { described_class.new(name: name) }

  its(:data_model) { should == MinceMigrator::RanMigrationDataModel }
  its(:fields){ should == [:name] }
  its(:name) { should == name }

  it 'can be deleted' do
    described_class.data_model.should_receive(:delete_by_params).with(name: name)

    subject.delete
  end
end

describe MinceMigrator::RanMigration, 'Class methods:' do
  describe 'finding by name' do
    subject { described_class.find_by_name(name) }

    let(:name) { mock }

    before do
      described_class.data_model.stub(:find_by_field).with(:name, name).and_return(data)
    end

    context 'when it exists' do
      let(:data) { mock }
      let(:model) { mock }

      before do
        described_class.stub(:new).with(data).and_return(model)
      end

      it 'returns the model 'do
        subject.should == model
      end
    end

    context 'when it does not exist 'do
      let(:data) { nil }

      it 'returns nil' do
        subject.should be_nil
      end
    end
  end
end

describe MinceMigrator::RanMigrationDataModel do
  it 'stores everything in the "migrations" collection' do
    described_class.data_collection.should == :migrations
  end

  it 'has the name field' do
    described_class.data_fields.should == [:name]
  end
end

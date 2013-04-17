require_relative '../../../lib/mince_migrator/creator'

describe MinceMigrator::Creator do
  context 'when a name is not provided' do
    let(:migration_name) { mock valid?: false, reasons_for_failure: mock, value: mock }

    before do
      MinceMigrator::Migrations::Name.stub(:new).with(nil).and_return(migration_name)
    end

    its(:can_create_migration?) { should be_false }
    its(:reasons_for_failure) { should == migration_name.reasons_for_failure }
  end

  context 'when a name is provided' do
    subject { described_class.new(name) }

    let(:name) { mock }
    let(:migration_name) { mock value: mock}

    before do
      MinceMigrator::Migrations::Name.stub(:new).with(name).and_return(migration_name)
    end

    context 'when the name is invalid' do
      let(:reasons_for_failure) { mock }

      before do
        migration_name.stub(valid?: false, reasons_for_failure: reasons_for_failure)
      end

      its(:can_create_migration?) { should be_false }
      its(:reasons_for_failure) { should == reasons_for_failure }
    end

    context 'when the name is valid' do
      let(:opened_file) { mock write: nil, close: nil }
      let(:migration_file) { mock path: mock, full_path: mock, body: mock, full_relative_path: mock }
      let(:versioned_file) { mock next_unused_version: migration_file }

      before do
        migration_name.stub(valid?: true, value: mock)
        FileUtils.stub(:mkdir_p).with(MinceMigrator::Config.migration_dir)
        MinceMigrator::Migrations::VersionedFile.stub(:new).with(migration_name.value).and_return(versioned_file)
        ::File.stub(:open).with(migration_file.full_path, 'w+').and_return(opened_file)
        ::File.stub(:exists?).with(migration_file.full_path).and_return(false)
      end

      its(:migration_file_relative_path){ should == migration_file.full_relative_path }

      it 'insures the path to the migraiton file exists' do
        FileUtils.should_receive(:mkdir_p).with(MinceMigrator::Config.migration_dir)

        subject.create_migration
      end

      it 'can create the migration' do
        subject.can_create_migration?.should be_true
      end

      it 'creates a migration file' do
        opened_file.should_receive(:write).with(migration_file.body)
        opened_file.should_receive(:close)

        subject.create_migration
      end
    end
  end
end

describe MinceMigrator::Creator, 'Class level methods' do
  it 'can create a migration' do
    name = mock
    creator = mock can_create_migration?: true
    described_class.should_receive(:new).with(name).and_return(creator)
    creator.should_receive(:create_migration)

    described_class.create(name)
  end
end

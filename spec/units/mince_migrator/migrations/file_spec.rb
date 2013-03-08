require_relative '../../../../lib/mince_migrator/migrations/file'

describe MinceMigrator::Migrations::File do
  subject { described_class.new(name) }

  let(:expected_class_name) { 'ChangeSpacesToUnderscores' }
  let(:name) { "Change spaces to underscores" }
  let(:migration_template) { mock render: mock }

  before do
    MinceMigrator::Migrations::Template.stub(:new).with(expected_class_name).and_return(migration_template)
    File.stub(:exists?).with(subject.full_path).and_return(false)
  end

  its(:name) { should == "change_spaces_to_underscores" }
  its(:filename) { should == "#{subject.name}.rb" }
  its(:full_path) { should == File.join(subject.path, subject.filename) }
  its(:full_relative_path) { should == File.join(subject.relative_path, subject.filename) }
  its(:relative_path) { should == "db/migrations" }
  its(:path) { should == File.join(Dir.pwd, "db", "migrations") }
  its(:body) { should == migration_template.render }

  context 'when a migration with the same name already exists' do
    let(:original_full_path) { File.join(subject.path, "change_spaces_to_underscores.rb") }
    let(:second_full_path) { File.join(subject.path, "change_spaces_to_underscores_2.rb") }
    let(:new_full_path) { File.join(subject.path, "change_spaces_to_underscores_3.rb") }

    before do
      File.stub(:exists?).with(original_full_path).and_return(true)
      File.stub(:exists?).with(second_full_path).and_return(true)
      File.stub(:exists?).with(new_full_path).and_return(false)
    end

    it 'appends a number to the end of the file' do
      subject = described_class.new(name)

      subject.full_path.should == new_full_path
    end
  end
end

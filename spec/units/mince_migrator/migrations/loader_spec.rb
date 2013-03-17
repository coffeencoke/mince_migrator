require_relative '../../../../lib/mince_migrator/migrations/loader'

describe MinceMigrator::Migrations::Loader do
  subject { described_class.new full_path: full_path, klass_name: klass_name }

  context 'when the file exists and is a mince migrator migration file' do
    let(:full_path) { File.expand_path('../../../../support/test_migration.rb', __FILE__) }
    let(:klass_name) { 'TestMigration' }
    let(:expected_klass) { eval "::MinceMigrator::Migrations::#{klass_name}" }

    its(:klass) { should == expected_klass }

    it 'loads the migration into memory' do
      subject.call

      expected_klass.run.should == "Returning a value as a result of the run method"
    end
  end

  context 'when the file exists but is not a mince migrator migration file' do
    let(:full_path) { File.expand_path('../../../../support/not_a_migration.rb', __FILE__) }
    let(:klass_name) { 'Foo' }

    it 'raises an exception' do
      expect { subject.call }.to raise_exception('invalid migration')
    end
  end

  context 'when the file does not exist' do
    pending 'raises an exception' do
      expect { subject }.to_raise('migration not found')
    end
  end
end


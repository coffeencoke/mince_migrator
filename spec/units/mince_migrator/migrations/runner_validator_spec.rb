require_relative '../../../../lib/mince_migrator/migrations/runner_validator'

describe MinceMigrator::Migrations::RunnerValidator do
  subject { described_class.new(migration) }

  before do
    Mince::Config.interface = mock
  end

  context 'when the migration exists' do
    let(:migration) { mock }

    context 'when it has already ran' do
      before do
        migration.stub(ran?: true)
        subject.call
      end

      its(:call) { should be_false }
      its(:errors) { should == ['Migration has already ran'] }
    end
  end

  context 'when the migration does not exist' do
    let(:migration) { nil }

    before do
      subject.call
    end

    its(:call) { should be_false }
    its(:errors) { should == ['Migration does not exist'] }
  end

  context 'when the mince interface is not set' do
    let(:migration) { mock }

    before do
      Mince::Config.interface = nil
      subject.call
    end

    its(:call) { should be_false }
    its(:errors) { should == ['Mince interface is not set'] }
  end
end

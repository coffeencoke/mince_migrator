require_relative '../../../lib/mince_migrator/cli_helper'

module MinceMigrator
  describe CliHelper do
    subject { klass.new }

    let(:klass) do
      Class.new do
        include CliHelper
      end
    end
    let(:options) { mock }
    let(:reasons_for_failure) { mock }

    before do
      subject.stub(:puts)
    end

    describe 'deleting a migration' do
      let(:deleter) { mock }

      before do
        Deleter.stub(:new).with(options).and_return(deleter)
      end

      context 'when the migration can be deleted' do
        before do
          deleter.stub(can_delete_migration?: true, name: mock)
        end

        it 'deletes it' do
          deleter.should_receive(:delete_migration)

          subject.delete_migration(options)
        end
      end

      context 'when the migration cannot be deleted' do
        before do
          deleter.stub(can_delete_migration?: false, reasons_for_failure: reasons_for_failure)
        end

        it 'fails with an error message' do
          subject.should_receive(:help_now!).with(reasons_for_failure)

          subject.delete_migration(options)
        end
      end
    end
  end
end

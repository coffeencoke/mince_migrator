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

    describe 'running a migration' do
      let(:runner) { mock }

      before do
        Migrations::Runner.stub(:new).with(options).and_return(runner)
      end

      context 'when the migration can be ran' do
        before do
          runner.stub(can_run_migration?: true, name: mock)
        end

        it 'runs it' do
          runner.should_receive(:run_migration)

          subject.run_migration(options)
        end
      end

      context 'when the migration cannot be ran' do
        before do
          runner.stub(can_run_migration?: false, reasons_for_failure: reasons_for_failure)
        end

        it 'fails with an error message' do
          subject.should_receive(:help_now!).with(reasons_for_failure)

          subject.run_migration(options)
        end
      end
    end

    describe 'creating a migration' do
      let(:creator) { mock migration_file_relative_path: mock }

      before do
        Creator.stub(:new).with(options).and_return(creator)
      end

      context 'when the migration can be created' do
        before do
          creator.stub(can_create_migration?: true, name: mock)
        end

        it 'creates it' do
          creator.should_receive(:create_migration)

          subject.create_migration(options)
        end
      end

      context 'when the migration cannot be created' do
        before do
          creator.stub(can_create_migration?: false, reasons_for_failure: reasons_for_failure)
        end

        it 'fails with an error message' do
          subject.should_receive(:help_now!).with(reasons_for_failure)

          subject.create_migration(options)
        end
      end
    end

    describe 'reverting a migration' do
      let(:reverter) { mock }

      before do
        Reverter.stub(:new).with(options).and_return(reverter)
      end

      context 'when the migration can be reverted' do
        before do
          reverter.stub(can_revert_migration?: true, name: mock)
        end

        it 'reverts it' do
          reverter.should_receive(:revert_migration)

          subject.revert_migration(options)
        end
      end

      context 'when the migration cannot be reverted' do
        before do
          reverter.stub(can_revert_migration?: false, reasons_for_failure: reasons_for_failure)
        end

        it 'fails with an error message' do
          subject.should_receive(:help_now!).with(reasons_for_failure)

          subject.revert_migration(options)
        end
      end
    end
  end
end

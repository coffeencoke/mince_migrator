require_relative '../../../lib/mince_migrator/migration'

require 'time'

describe MinceMigrator::Migration, 'class methods:' do
  describe 'Loading from a file' do
    subject { described_class.load_from_file(path_to_file) }

    let(:path_to_file) { File.expand_path('../../../support/test_migration.rb', __FILE__) }

    it 'provides access to the time the migration was created' do
      expected_time = Time.parse('2013-03-04 09:31:28 UTC')

      subject.time_created.should == expected_time
    end
  end
end

require 'debugger'

module MinceMigrator
  class Migration
    def self.load_from_file(path_to_file)
      require path_to_file

      debugger
      puts 'asdf'
    end
  end
end

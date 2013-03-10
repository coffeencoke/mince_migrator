require 'debugger'

module MinceMigrator
  require_relative 'migrations/file'

  class Migration
    attr_reader :time_created, :name, :status, :relative_path, :path

    def initialize(migration_file)
      @klass = migration_file.klass
      @time_created = @klass.time_created
      split_name = migration_file.name.split("_")
      @name = "#{split_name[0].capitalize} #{split_name[1..-1].join(" ")}"
      @status = "not ran"
      @relative_path = migration_file.full_relative_path
      @path = migration_file.full_path
    end

    def self.load_from_file(path_to_file)
      require path_to_file

      file = Migrations::File.load_from_file(path_to_file)
      new file
    end
  end
end

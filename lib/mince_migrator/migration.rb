require 'debugger'

module MinceMigrator
  require_relative 'migrations/file'
  require_relative 'ran_migration'
  require_relative 'migrations/name'

  class Migration
    attr_reader :time_created, :name, :status, :relative_path, :path

    def initialize(options)
      @klass = options[:klass]
      @time_created = @klass.time_created
      self.name = options[:name]
      @relative_path = options[:relative_path]
      @path = options[:path]
    end

    def age
      @age ||= "#{(Time.now.utc.to_date - time_created.to_date).to_i}d"
    end

    def name=(val)
      @name ||= Migrations::Name.new(val).value
    end

    def run
      @klass.run
    end

    def revert
      @klass.revert
    end

    def ran?
      !!ran_migration
    end

    def status
      ran? ? 'ran' : 'not ran'
    end

    def ran_migration
      @ran_migration ||= RanMigration.find_by_name(name)
    end

    def self.find(name)
      if file = Migrations::File.find(name)
        new_from_file file
      end
    end

    def self.load_from_file(path_to_file)
      new_from_file Migrations::File.load_from_file(path_to_file)
    end

    def self.new_from_file(file)
      new(
        klass: file.klass, 
        name: file.name, 
        relative_path: file.full_relative_path, 
        path: file.full_path
      )
    end
  end
end

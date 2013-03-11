require 'debugger'

module MinceMigrator
  require_relative 'migrations/file'

  class Migration
    attr_reader :time_created, :name, :status, :relative_path, :path

    def initialize(options)
      @klass = options[:klass]
      @time_created = @klass.time_created
      self.name = options[:name]
      @status = "not ran"
      @relative_path = options[:relative_path]
      @path = options[:path]
    end

    def name=(val)
      words = split_name(val).each_with_index.map do |word, i|
        i == 0 ? word.capitalize : word.downcase
      end
      @name = words.join(" ")
    end

    def split_name(val)
      val.split("_").map{|a| a.split(" ") }.flatten
    end

    def self.load_from_file(path_to_file)
      require path_to_file

      file = Migrations::File.load_from_file(path_to_file)
      new(
        klass: file.klass, 
        name: file.name, 
        relative_path: file.full_relative_path, 
        path: file.full_path
      )
    end
  end
end

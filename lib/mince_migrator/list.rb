module MinceMigrator
  require_relative 'config'
  require_relative 'migration'

  class List
    def all
      @all ||= filelist.map{|a| Migration.load_from_file(a) }.sort_by(&:time_created)
    end

    def number_of_migrations
      all.size
    end

    def filelist
      @filelist ||= Dir.glob(filelist_pattern)
    end

    def filelist_pattern
      File.join(Config.migration_dir, '*')
    end
  end
end

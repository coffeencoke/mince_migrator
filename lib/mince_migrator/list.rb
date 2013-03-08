module MinceMigrator
  require_relative 'config'
  require_relative 'migration'

  class List
    def all
      @all ||= Dir.glob("#{Config.migration_dir}/*")
    end

    def number_of_migrations
      all.size
    end
  end
end

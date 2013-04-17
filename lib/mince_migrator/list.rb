module MinceMigrator
  require_relative 'config'
  require_relative 'migration'

  class List
    attr_reader :status

    def initialize(status=:any)
      @status = status
    end

    def all
      @all ||= all_for_status
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

    private

    def all_for_status
      filtered_by_status(all_for_any_status).sort_by(&:time_created)
    end

    def all_for_any_status
      filelist.map{|a| Migration.load_from_file(a) }
    end

    def filtered_by_status(migrations)
      migrations.select { |m| matches_status?(m) }
    end

    def matches_status?(migration)
      status == :any || migration.status == status
    end
  end
end

module MinceMigrator
  class List
    def all
      @all ||= []
    end

    def number_of_migrations
      all.size
    end
  end
end

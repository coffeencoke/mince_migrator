module MinceMigrator
  class Deleter
    def initialize(name)
    end

    def can_delete_migration?
      false
    end
  end
end

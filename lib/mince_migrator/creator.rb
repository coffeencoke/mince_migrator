module MinceMigrator
  class Creator
    attr_reader :name
    def initialize(name=nil)
      @name = name
    end

    def can_create_migration?
      !!name
    end
  end
end

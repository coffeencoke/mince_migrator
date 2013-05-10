module MinceMigrator
  require_relative 'migrations/name'
  require_relative 'migration'
  require_relative 'config'

  class Reverter
    attr_reader :name, :migration_name

    def initialize(options)
      if options[:migration]
        @migration = options[:migration]
        @migration_name = Migrations::Name.new migration.name
      elsif options[:name]
        @migration_name = Migrations::Name.new options[:name]
      end
      @name = migration_name.value
      @errors = []
    end

    def can_revert_migration?
      @errors = []
      validate_migration
      validate_ran_migration
      @errors.empty?
    end

    def validate_ran_migration
      @errors << "Migration has not ran" if migration_not_ran?
    end

    def validate_migration
      @errors << "Migration does not exist with name '#{name}'" if migration.nil?
    end

    def revert_migration
      migration.revert
      ran_migration.delete
      true
    end

    def reasons_for_failure
      @errors.join ", "
    end

    def migration
      @migration ||= Migration.find(name)
    end

    def migration_not_ran?
      migration && !migration.ran?
    end

    def ran_migration
      migration.ran_migration if migration
    end
  end
end

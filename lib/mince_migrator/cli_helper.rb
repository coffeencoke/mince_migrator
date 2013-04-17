module MinceMigrator
  module CliHelper
    def delete_migration(options)
      deleter = MinceMigrator::Deleter.new(options)
      if deleter.can_delete_migration?
        puts "Deleting #{deleter.name}..."
        deleter.delete_migration
        puts "Migration deleted successfully"
      else
        help_now!(deleter.reasons_for_failure)
      end
    end

    def run_migration(options)
      runner = MinceMigrator::Migrations::Runner.new(options)
      if runner.can_run_migration?
        puts "Running #{runner.name}..."
        runner.run_migration
        puts "Migration finished."
      else
        help_now!(runner.reasons_for_failure)
      end
    end

    def create_migration(name)
      creator = MinceMigrator::Creator.new(name)
      if creator.can_create_migration?
        puts "Creating #{creator.name}..."
        creator.create_migration
        puts "Migration created at #{creator.migration_file_relative_path}"
      else
        help_now!(creator.reasons_for_failure)
      end
    end

    def list_migrations(list)
      if list.all.any?
        MinceMigrator::ListReport.new(list).run
      else
        puts "\nThere are no migrations in the '#{MinceMigrator::Config.migration_relative_dir}' directory.\n".red
        puts "run the following for more info to create a migration:\n\n"
        puts "  mince_migrator create --help\n\n".green
      end
    end

    def revert_migration(options)
      reverter = MinceMigrator::Reverter.new(options)
      if reverter.can_revert_migration?
        puts "Reverting #{reverter.name}..."
        reverter.revert_migration
        puts "Migration reverted successfully"
      else
        help_now!(reverter.reasons_for_failure)
      end
    end

    def show_migration(name)
      if migration = MinceMigrator::Migration.find(name)
        MinceMigrator::StatusReport.new(migration).run
      else
        puts "No migration was found with name: '#{name}'"
      end
    end
  end
end

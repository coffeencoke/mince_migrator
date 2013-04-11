module MinceMigrator
  require 'command_line_reporter'
  
  class StatusReport
    include CommandLineReporter

    attr_reader :migration

    def initialize(migration)
      @migration = migration
    end

    def run
      vertical_spacing 2
      header title: "Migration Details for #{migration.name}", bold: true, rule: true, align: 'center', width: 70, timestamp: true

      table border: false do
        row do
          column 'Name', width: 15
          column migration.name, width: 30
        end
        row do
          column 'Status'
          if migration.status == 'not ran'
            column migration.status, color: 'red'
          else
            column migration.status, color: 'green'
          end
        end
        row do
          column 'Age'
          column migration.age
        end
        row do
          column 'Date Created'
          column migration.time_created.strftime("%m/%d/%Y")
        end
      end
    end
  end
end

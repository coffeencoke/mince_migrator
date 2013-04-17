module MinceMigrator
  require 'command_line_reporter'
  
  class ListReport
    include CommandLineReporter

    def initialize(list)
      @list = list
    end

    def run
      vertical_spacing 2
      header title: 'List Of All Migrations', bold: true, rule: true, align: 'center', width: 70, timestamp: true

      table border: false do
        row header: true do
          column 'Name', width: 40
          column 'Status', width: 10
          column 'Age', width: 5
          column 'Date Created', width: 15
        end
        @list.all.each do |migration|
          row  do
            column migration.name
            status_column(migration)
            column migration.age
            column migration.time_created.strftime("%m/%d/%Y")
          end
        end
      end

      footer title: "Total Migrations: #{@list.all.size}", bold: true, color: 'green'
    end

    def status_column(migration)
      color = migration.ran? ? 'green' : 'red'
      column migration.status, color: color
    end
  end
end

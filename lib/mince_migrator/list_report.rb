module MinceMigrator
  require 'command_line_reporter'
  
  class ListReport
    include CommandLineReporter

    attr_reader :sum_ran, :sum_not_ran

    def initialize(list)
      @list = list
      @sum_ran = 0
      @sum_not_ran = 0
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
            if migration.name.size > 40
              column "#{migration.name[0..36]}..."
            else
              column migration.name
            end
            status_column(migration)
            column migration.age
            column migration.time_created.strftime("%m/%d/%Y")
          end
        end
      end

      vertical_spacing 2

      table border: false do
        row do
          column "Ran", width: 6
          column sum_ran, color: 'green', width: 5
          column "Not ran", width: 8
          column sum_not_ran, color: 'red', width: 5
        end
        row bold: true do
          column "Total", width: 6
          column total_number_of_migrations, width: 5
        end
      end
    end

    def total_number_of_migrations
      sum_ran + sum_not_ran
    end

    def status_column(migration)
      if migration.ran?
        @sum_ran += 1
        color = 'green'
      else
        @sum_not_ran += 1
        color = 'red'
      end
      column migration.status, color: color
    end
  end
end

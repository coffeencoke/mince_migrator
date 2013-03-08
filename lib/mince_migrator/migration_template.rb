module MinceMigrator
  require 'mustache'

  class MigrationTemplate < Mustache

    self.template_file = File.expand_path('../templates/migration_template.mustache', __FILE__)

    attr_reader :klass_name, :time_created

    def initialize(klass_name)
      @klass_name = klass_name
      @time_created = Time.now.utc.to_s
    end
  end
end

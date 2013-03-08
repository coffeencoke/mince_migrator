module MinceMigrator
  module Migrations
    require 'mustache'

    class Template < Mustache
      self.template_file = File.expand_path('../template.mustache', __FILE__)

      attr_reader :klass_name, :time_created

      def initialize(klass_name)
        @klass_name = klass_name
        @time_created = Time.now.utc.to_s
      end
    end
  end
end

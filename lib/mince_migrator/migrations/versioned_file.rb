module MinceMigrator
  module Migrations
    require_relative 'file'

    class VersionedFile
      attr_reader :version

      def initialize(name, version = 1)
        @version = version
        @name = name
      end

      def name
        version > 1 ? "#{@name}_#{version}" : @name
      end

      def file
        @file ||= File.new(name)
      end

      def next_unused_version
        if file.persisted?
          bump
          next_unused_version
        else
          file
        end
      end

      private

      def bump
        @version += 1
        @file = File.new(name)
      end
    end
  end
end

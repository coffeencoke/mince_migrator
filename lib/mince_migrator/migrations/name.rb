module MinceMigrator
  module Migrations
    class Name
      attr_reader :value

      def initialize(value)
        self.value = value if value
      end

      def filename
        @filename ||= "#{value.downcase.gsub(" ", "_")}.rb"
      end

      def value=(val)
        normalized_string = normalized_string(val)
        @value = capitalized_phrase(normalized_string)
      end

      def capitalized_phrase(val)
        val.split(' ').each_with_index.map do |word, i|
          i == 0 ? word.capitalize : word.downcase
        end.join(" ")
      end

      def normalized_string(val)
        val = val.gsub(/[-_]/, ' ') # convert dashes and underscores to spaces
        pattern = /(^[0-9]|[^a-zA-Z0-9\s])/ # only allow letters and numbers, but do not allow numbers at the beginning
        val.gsub(pattern, '')
      end

      def valid?
        !value.nil? && value != ''
      end
    end
  end
end


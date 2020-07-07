# frozen_string_literal: true

module Web
  module Stats
    # Prints to the console the stats
    class Printer
      def initialize(stats)
        @stats = stats
        @max_width = 26
      end

      def self.print(stats)
        new(stats).print
      end

      def print
        puts title('WEBLOG STATS')
        print_section(:total, 'Total Visits')
        print_section(:unique, 'Unique Views')
      end

      private

      def title(text)
        "-- #{text} --".center(@max_width)
      end

      def separator
        '=' * @max_width
      end

      def print_section(key, section_title)
        puts separator
        puts title(section_title)
        @stats[key].each do |path, views|
          puts "#{path.ljust(15)} (#{views} views)"
        end
      end
    end
  end
end

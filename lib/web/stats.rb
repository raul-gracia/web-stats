# frozen_string_literal: true

require 'web/stats/version'
require 'web/stats/parser'
require 'web/stats/stats_service'
require 'web/stats/printer'

module Web
  module Stats
    # Reads a web log and gathers stats about the visits
    class Stats
      def self.show_stats(file)
        parsed_data = Parser.parse(file)
        stats = StatsService.gather_stats(parsed_data)
        Printer.print(stats)
      rescue Weblog::Parser::NoFileError
        puts "File doesn't exist"
      rescue Weblog::Parser::MalformedFileError
        puts 'The file content is malformed'
      end
    end
  end
end

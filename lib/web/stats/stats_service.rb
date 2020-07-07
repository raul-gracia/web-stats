# frozen_string_literal: true

module Web
  module Stats
    # Receives a structured array of parsed data and gathers
    # total and unique views statistics.
    class StatsService
      def initialize(parsed_data)
        @parsed_data = parsed_data
      end

      def self.gather_stats(parsed_data)
        new(parsed_data).gather_stats
      end

      def gather_stats
        grouped_stats = group_data

        total_views = {}
        unique_views = {}

        grouped_stats.each do |path, ips|
          total_views[path] = ips.count
          unique_views[path] = ips.uniq.count
        end

        sort_stats(total_views, unique_views)
      end

      private

      def group_data
        stats = Hash.new { |h, k| h[k] = [] }
        @parsed_data.each do |data|
          stats[data[:path]] << data[:ip]
        end
        stats
      end

      def sort_stats(total_views, unique_views)
        {
          total: total_views.sort_by(&:last).to_h,
          unique: unique_views.sort_by(&:last).to_h
        }
      end
    end
  end
end

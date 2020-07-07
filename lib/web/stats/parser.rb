# frozen_string_literal: true

module Web
  module Stats
    class NoFileError < StandardError; end
    class MalformedFileError < StandardError; end

    # Reads a file and returns a structured array of hashes with the info
    class Parser
      def initialize(filename)
        @filename = filename
      end

      def self.parse(filename)
        new(filename).parse
      end

      def parse
        data = []
        File.new(@filename)
            .each_line do |line|
          path, ip = line.split(' ')
          check_format(path, ip)
          data << { path: path, ip: ip }
        end

        data
      rescue Errno::ENOENT
        raise NoFileError
      end

      private

      def check_format(path, ip)
        raise MalformedFileError if path.nil? || ip.nil?
        raise MalformedFileError unless /\d{3}\.\d{3}\.\d{3}\.\d{3}/.match?(ip)
      end
    end
  end
end

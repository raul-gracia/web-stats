# frozen_string_literal: true

RSpec.describe Web::Stats::Printer do
  describe '.print' do
    let(:stats) do
      {
        total: {
          '/lions' => 5,
          '/bears' => 8
        },
        unique: {
          '/lions' => 1,
          '/bears' => 2
        }
      }
    end

    let(:output) do
      [
        '    -- WEBLOG STATS --    ',
        '==========================',
        '    -- Total Visits --    ',
        '/lions          (5 views)',
        '/bears          (8 views)',
        '    -- Unique Views --    ',
        '/lions          (1 views)',
        '/bears          (2 views)'
      ]
    end

    it 'ouputs the formatted stats' do
      printer = Web::Stats::Printer.new(stats)
      output.each do |line|
        expect(printer).to receive(:puts).with(line).at_least(:once)
      end

      printer.print
    end

    it 'delegates the class method to the instance method' do
      expect_any_instance_of(Web::Stats::Printer).to receive(:print).with(no_args).once

      Web::Stats::Printer.print(stats)
    end
  end
end

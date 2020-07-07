# frozen_string_literal: true

RSpec.describe Web::Stats::StatsService do
  describe '.gather_stats' do
    let(:parsed_data) do
      [
        { path: '/dogs', ip: '187.222.83.34' },
        { path: '/bears', ip: '192.168.1.1' },
        { path: '/bears', ip: '123.132.87.34' },
        { path: '/bears', ip: '192.168.1.1' },
        { path: '/lions', ip: '192.168.1.1' },
        { path: '/lions', ip: '187.222.83.34' },
        { path: '/lions', ip: '187.222.83.34' },
        { path: '/lions', ip: '187.211.11.84' },
        { path: '/lions', ip: '187.222.83.34' }
      ]
    end

    it 'returns the total and uniq views from the parsed data' do
      total_views = {
        '/lions' => 5,
        '/bears' => 3,
        '/dogs' => 1
      }
      unique_views = {
        '/lions' => 3,
        '/bears' => 2,
        '/dogs' => 1
      }

      stats = { total: total_views, unique: unique_views }

      expect(described_class.gather_stats(parsed_data)).to eq(stats)
    end
  end
end

# frozen_string_literal: true

RSpec.describe Web::Stats::Stats do
  it 'has a version number' do
    expect(Web::Stats::VERSION).not_to be nil
  end
  describe '.show_stats' do
    let(:good_filename) { 'spec/support/good_log.log' }
    let(:bad_filename) { 'spec/support/bad_log.log' }

    it 'delegates the calls to the different services' do
      expect(Web::Stats::Parser).to receive(:parse).with(good_filename).and_call_original
      parsed_data = [{ path: '/apples', ip: '392.168.001.001' },
                     { path: '/lions', ip: '123.226.023.023' },
                     { path: '/bears/5', ip: '175.211.123.004' }]

      expect(Web::Stats::StatsService).to receive(:gather_stats).with(parsed_data).and_call_original

      stats = { total: { '/apples' => 1, '/bears/5' => 1, '/lions' => 1 },
                unique: { '/apples' => 1, '/bears/5' => 1, '/lions' => 1 } }

      expect(Web::Stats::Printer).to receive(:print).with(stats)

      described_class.show_stats(good_filename)
    end

    context 'file doesnt exist' do
      it 'rescues from errors and displays message' do
        expect(described_class).to receive(:puts).with("File doesn't exist")
        allow(Web::Stats::Parser).to receive(:parse).and_raise(Web::Stats::NoFileError)

        described_class.show_stats('non_existent_file.log')
      end
    end

    context 'file is malformed' do
      it 'rescues from errors and displays message' do
        expect(described_class).to receive(:puts).with('The file content is malformed')
        allow(Web::Stats::Parser).to receive(:parse).and_raise(Web::Stats::MalformedFileError)

        described_class.show_stats(bad_filename)
      end
    end
  end
end

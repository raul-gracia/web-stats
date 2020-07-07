# frozen_string_literal: true

RSpec.describe Web::Stats::Parser do
  describe '.parse' do
    let(:good_filename) { 'spec/support/good_log.log' }
    let(:bad_filename) { 'spec/support/bad_log.log' }

    it 'reads a file and returns an array of path and ip' do
      data = [
        { path: '/apples', ip: '392.168.001.001' },
        { path: '/lions', ip: '123.226.023.023' },
        { path: '/bears/5', ip: '175.211.123.004' }
      ]
      expect(described_class.parse(good_filename)).to eq data
    end

    it 'raises an error when the file doesnt exist' do
      expect { described_class.parse('non_existent_file.log') }
        .to raise_error Web::Stats::NoFileError
    end

    it 'raises an error when the file is malformed' do
      expect { described_class.parse(bad_filename) }
        .to raise_error Web::Stats::MalformedFileError
    end
  end
end

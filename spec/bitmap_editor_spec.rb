require 'bitmap_editor.rb'

describe BitmapEditor do

  let(:invalid_path) { 'non/existent/file.txt' }
  subject(:bitmap_editor) { described_class.new }

  it { is_expected.to respond_to(:run).with(1).argument }

  describe '#run' do
    it 'raises an exception if file path is invalid' do
      allow(File).to receive(:exists?).with(invalid_path).and_return(false)

      expect{ bitmap_editor.run invalid_path }
        .to raise_error("Could not find file at #{invalid_path}")
    end
  end
end

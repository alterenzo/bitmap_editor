require 'bitmap_editor.rb'

describe BitmapEditor do

  let(:invalid_path) { 'non/existent/file.txt' }
  let(:valid_path) { 'valid/path/file.txt' }
  # let(:file_content) { StringIO.new "I 3 5\n" }
  let(:valid_file) { double :file }
  subject(:bitmap_editor) { described_class.new }

  before(:each) do
    allow(File).to receive(:exists?).with(valid_path).and_return(true)
  end

  it { is_expected.to respond_to(:run).with(1).argument }

  describe '#run' do
    it 'raises an exception if file path is invalid' do
      allow(File).to receive(:exists?).with(invalid_path).and_return(false)

      expect{ bitmap_editor.run invalid_path }
        .to raise_error("Could not find file at #{invalid_path}")
    end

    it 'opens a file and iterates over each line' do
      allow(File).to receive(:open).with(valid_path).and_return(valid_file)

      expect(valid_file).to receive(:each_line)

      bitmap_editor.run valid_path
    end

    it 'initializes a new bitmap image with width and heigth' do
      width = 1 + rand(5)
      heigth = 1 + rand(5)
      init_command = StringIO.new "I #{width} #{heigth}\n"
      allow(File).to receive(:open).with(valid_path).and_return(init_command)

      bitmap_editor.run valid_path

      expect(bitmap_editor.bitmap.length).to eq heigth
      expect(bitmap_editor.bitmap[0].length).to eq width
    end
  end
end

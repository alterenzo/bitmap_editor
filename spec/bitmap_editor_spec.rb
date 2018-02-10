require 'bitmap_editor.rb'

describe BitmapEditor do
  let(:invalid_path) { 'non/existent/file.txt' }
  let(:valid_path) { 'valid/path/file.txt' }
  # let(:file_content) { StringIO.new "I 3 5\n" }
  let(:valid_file) { double :file }
  subject(:bitmap_editor) { described_class.new }

  before(:each) do
    allow(File).to receive(:exist?).with(valid_path).and_return(true)
  end

  it { is_expected.to respond_to(:run).with(1).argument }

  describe '#run' do
    it 'raises an exception if file path is invalid' do
      allow(File).to receive(:exist?).with(invalid_path).and_return(false)

      expect { bitmap_editor.run invalid_path }
        .to raise_error("Could not find file at #{invalid_path}")
    end

    it 'opens a file and iterates over each line' do
      allow(File).to receive(:open).with(valid_path).and_return(valid_file)

      expect(valid_file).to receive(:each_line)

      bitmap_editor.run valid_path
    end

    it 'delegates the display of the bitmap' do
      show_command = StringIO.new "S\n"
      allow(File).to receive(:open).with(valid_path).and_return(show_command)

      expect(bitmap_editor).to receive(:show_bitmap).once

      bitmap_editor.run valid_path
    end

    it 'delegates the creation of a bitmap' do
      width = rand(1...5)
      height = rand(1..5)
      init_command = StringIO.new "I #{width} #{height}\n"
      allow(File).to receive(:open).with(valid_path).and_return(init_command)

      expect(bitmap_editor).to receive(:create_bitmap)
        .with(height: height, width: width)

      bitmap_editor.run valid_path
    end
  end

  describe '#create_bitmap' do
    it 'creates a two dimensional array with given height and width' do
      width = rand(1..5)
      height = rand(1..5)

      result = bitmap_editor.create_bitmap(height: height, width: width)

      expect(result.length).to eq height
      expect(result[0].length).to eq width
    end

    it 'fills the newly created bitmap with white' do
      bitmap = bitmap_editor.create_bitmap(height: 2, width: 2)

      expect(bitmap.flatten.all? { |color| color.equal? BitmapEditor::WHITE })
        .to be true
    end
  end

  describe '#show_bitmap' do
    it 'raises an error if there is no bitmap to show' do
      bitmap = []

      expect { bitmap_editor.show_bitmap(bitmap: bitmap) }
        .to raise_error('There is not image to show yet')
    end

    it 'prints a representation of the bitmap to the standard output' do
      bitmap = Array.new(2, Array.new(2, BitmapEditor::WHITE))
      expect { bitmap_editor.show_bitmap(bitmap: bitmap) }
        .to output("OO\nOO\n").to_stdout
    end
  end
end

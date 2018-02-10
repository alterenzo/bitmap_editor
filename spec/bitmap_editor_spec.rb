require 'bitmap_editor.rb'

describe BitmapEditor do
  let(:invalid_path) { 'non/existent/file.txt' }
  let(:valid_path) { 'valid/path/file.txt' }
  let(:renderer) { double 'Renderer' }
  let(:valid_file) { double :file }
  subject(:bitmap_editor) { described_class.new(renderer: renderer) }

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

    it 'exectutes each command on file' do
      file = StringIO.new "I 3 4\nL 3 4 C\nS\n"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      expect(bitmap_editor).to receive(:execute_instruction).exactly(3).times

      bitmap_editor.run valid_path
    end
  end

  describe '#execute_command' do
    it 'delegates the creation of a bitmap' do
      width = rand(1...5)
      height = rand(1..5)
      init_instruction = "I #{width} #{height}\n"

      expect(renderer).to receive(:create_bitmap)
        .with(height: height, width: width)

      bitmap_editor.execute_instruction init_instruction
    end

    it 'delegates the display of the bitmap' do
      show_instruction = "S\n"

      expect(renderer).to receive(:show_bitmap).once

      bitmap_editor.execute_instruction show_instruction
    end

    it 'delegates the coloring of a pixel' do
      color_instruction = "L 1 3 R"

      expect(renderer).to receive(:color_pixel)
        .with(x: 1, y: 3, color: "R", bitmap: instance_of(Array))

      bitmap_editor.execute_instruction color_instruction
    end
  end
end

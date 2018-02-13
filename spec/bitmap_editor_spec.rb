require 'bitmap_editor.rb'

describe BitmapEditor do
  let(:invalid_path) { 'non/existent/file.txt' }
  let(:valid_path) { 'valid/path/file.txt' }
  let(:renderer) { double 'Renderer' }
  let(:valid_file) { double :file }
  subject(:bitmap_editor) { described_class.new(renderer: renderer) }

  before(:each) do
    allow(File).to receive(:exist?).with(valid_path).and_return(true)
    allow(renderer).to receive(:create_bitmap)
    allow(renderer).to receive(:color_pixel)
    allow(renderer).to receive(:horizontal_line)
    allow(renderer).to receive(:vertical_line)

    allow(bitmap_editor).to receive(:validate_init_instruction)
    allow(bitmap_editor).to receive(:validate_color_pixel_instruction)
    allow(bitmap_editor).to receive(:validate_horizontal_line_instruction)
    allow(bitmap_editor).to receive(:validate_vertical_line_instruction)
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

    it 'executes each command on file' do
      file = StringIO.new "I 3 4\nL 3 4 C\nS\n"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      expect(bitmap_editor).to receive(:execute_instruction).exactly(3).times

      bitmap_editor.run valid_path
    end

    it 'stops executing if an error is encountered' do
      file = StringIO.new "GOOD\nGOOD\nFAIL\nGOOD"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      allow(bitmap_editor).to receive(:execute_instruction).with("FAIL\n").and_raise(UnrecognisedInstructionError.new('errorMessage'))
      allow(bitmap_editor).to receive(:execute_instruction).with("GOOD\n")

      expect(bitmap_editor).to receive(:execute_instruction).exactly(3).times

      bitmap_editor.run valid_path
    end

    it 'catches UnrecognisedInstructionError raised during the execution and outputs on the console' do
      file = StringIO.new "FAIL"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      allow(bitmap_editor).to receive(:execute_instruction).with('FAIL').and_raise(UnrecognisedInstructionError.new('errorMessage'))

      expected_message = "An error of type UnrecognisedInstructionError was encountered while executing the"\
        " instruction: FAIL\nError message: errorMessage\n"

      expect{ bitmap_editor.run valid_path }.to output(expected_message).to_stdout
    end

    it 'catches InvalidInputError raised during the execution and outputs on the console' do
      file = StringIO.new "FAIL"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      allow(bitmap_editor).to receive(:execute_instruction).with('FAIL').and_raise(InvalidInputError.new('errorMessage'))

      expected_message = "An error of type InvalidInputError was encountered while executing the"\
        " instruction: FAIL\nError message: errorMessage\n"

      expect{ bitmap_editor.run valid_path }.to output(expected_message).to_stdout
    end

    it 'catches RendererError raised during the execution and outputs on the console' do
      file = StringIO.new "FAIL"
      allow(File).to receive(:open).with(valid_path).and_return(file)

      allow(bitmap_editor).to receive(:execute_instruction).with('FAIL').and_raise(RendererError.new('errorMessage'))

      expected_message = "An error of type RendererError was encountered while executing the"\
        " instruction: FAIL\nError message: errorMessage\n"

      expect{ bitmap_editor.run valid_path }.to output(expected_message).to_stdout
    end
  end

  describe '#execute_instruction' do
    it 'calls a method to validate the init instruction' do
      instruction = 'I 3 4'

      expect(bitmap_editor).to receive(:validate_init_instruction)
        .with(instruction)

      bitmap_editor.execute_instruction instruction
    end

    it 'calls a method to validate the color pixel instruction' do
      instruction = 'L 3 4 F'

      expect(bitmap_editor).to receive(:validate_color_pixel_instruction)
        .with(instruction)

      bitmap_editor.execute_instruction instruction
    end

    it 'calls a method to validate the horizontal line instruction' do
      instruction = 'H 1 3 4 F'

      expect(bitmap_editor).to receive(:validate_horizontal_line_instruction)
        .with(instruction)

      bitmap_editor.execute_instruction instruction
    end

    it 'calls a method to validate the vertical line instruction' do
      instruction = 'V 1 3 4 F'

      expect(bitmap_editor).to receive(:validate_vertical_line_instruction)
        .with(instruction)

      bitmap_editor.execute_instruction instruction
    end

    it 'delegates the creation of a bitmap' do
      width = rand(1...5)
      height = rand(1..5)
      init_instruction = "I #{width} #{height}\n"

      expect(renderer).to receive(:create_bitmap)
        .with(height: height, width: width)

      bitmap_editor.execute_instruction init_instruction
    end

    it 'delegates the clearing of the bitmap' do
      clear_instruction = 'C'

      expect(renderer).to receive(:clear_bitmap)
        .with(bitmap: instance_of(Array))

      bitmap_editor.execute_instruction clear_instruction
    end

    it 'delegates the display of the bitmap' do
      show_instruction = "S\n"

      expect(renderer).to receive(:show_bitmap).once

      bitmap_editor.execute_instruction show_instruction
    end

    it 'delegates the coloring of a pixel' do
      color_instruction = 'L 1 3 R'

      expect(renderer).to receive(:color_pixel)
        .with(x: 1, y: 3, color: 'R', bitmap: instance_of(Array))

      bitmap_editor.execute_instruction color_instruction
    end

    it 'delegates the coloring of an horizontal line' do
      color_instruction = 'H 1 3 4 R'

      expect(renderer).to receive(:horizontal_line)
        .with(row: 4, x1: 1, x2: 3, color: 'R', bitmap: instance_of(Array))

      bitmap_editor.execute_instruction color_instruction
    end

    it 'delegates the coloring of a vertical line' do
      color_instruction = 'V 1 3 4 C'

      expect(renderer).to receive(:vertical_line)
        .with(column: 1, y1: 3, y2: 4, color: 'C', bitmap: instance_of(Array))

      bitmap_editor.execute_instruction color_instruction
    end

    it 'raises an error if the input is not recognised' do
      unrecognised_instruction = 'UNRECOGNISED'
      expect{ bitmap_editor.execute_instruction(unrecognised_instruction) }
        .to raise_error UnrecognisedInstructionError
    end
  end
end

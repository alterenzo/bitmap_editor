require_relative './renderer.rb'
require_relative 'validators/bitmap_editor_input_validator.rb'
require_relative 'errors/unrecognised_instruction_error.rb'

# Opens the provided file, iterates over each line and executes instructions
class BitmapEditor
  include BitmapEditorInputValidator

  INIT_INSTRUCTION = 'I'.freeze
  SHOW_INSTRUCTION = 'S'.freeze
  COLOR_INSTRUCTION = 'L'.freeze
  HORIZONTAL_LINE_INSTRUCTION = 'H'.freeze
  VERTICAL_LINE_INSTRUCTION = 'V'.freeze
  CLEAR_INSTRUCTION = 'C'.freeze

  def initialize(renderer: Renderer.new)
    @renderer = renderer
    @bitmap = []
  end

  def run(file)
    raise "Could not find file at #{file}" if file.nil? || !File.exist?(file)

    File.open(file).each_line do |line|
      begin
        execute_instruction(line)
      rescue UnrecognisedInstructionError, InvalidInputError, RendererError => e
        puts "An error of type #{e.class} was encountered while executing the"\
          " instruction: #{line.chomp}\nError message: #{e.message}"
        break
      end
    end
  end

  def execute_instruction(line)
    case extract_instruction(line)
    when INIT_INSTRUCTION
      validate_init_instruction(line)
      @bitmap = @renderer.create_bitmap(init_instr_arguments(line))
    when SHOW_INSTRUCTION
      @renderer.show_bitmap(bitmap: @bitmap.dup)
    when COLOR_INSTRUCTION
      validate_color_pixel_instruction(line)
      @bitmap = @renderer.color_pixel(color_instr_arguments(line))
    when HORIZONTAL_LINE_INSTRUCTION
      validate_horizontal_line_instruction(line)
      @bitmap = @renderer.horizontal_line(horizontal_line_instr_arguments(line))
    when VERTICAL_LINE_INSTRUCTION
      validate_vertical_line_instruction(line)
      @bitmap = @renderer.vertical_line(vertical_line_instr_arguments(line))
    when CLEAR_INSTRUCTION
      @bitmap = @renderer.clear(bitmap: @bitmap.dup)
    else
      raise UnrecognisedInstructionError.new("The instruction \"#{line.chomp}\" is not supported")
    end
  end

  private

  def extract_instruction(line)
    line.chomp[0]
  end

  def horizontal_line_instr_arguments(line)
    args = line.split
    { row: args[3].to_i,
      x1: args[1].to_i,
      x2: args[2].to_i,
      color: args[4],
      bitmap: @bitmap.dup }
  end

  def vertical_line_instr_arguments(line)
    args = line.split
    { column: args[1].to_i,
      y1: args[2].to_i,
      y2: args[3].to_i,
      color: args[4],
      bitmap: @bitmap.dup }
  end

  def init_instr_arguments(line)
    args = line.split
    { height: args[2].to_i,
      width: args[1].to_i }
  end

  def color_instr_arguments(line)
    args = line.split
    { x: args[1].to_i,
      y: args[2].to_i,
      color: args[3],
      bitmap: @bitmap.dup }
  end
end

require 'renderer.rb'

# Opens the provided file, iterates over each line and executes instructions
class BitmapEditor
  INIT_INSTRUCTION = 'I'.freeze
  SHOW_INSTRUCTION = 'S'.freeze
  COLOR_INSTRUCTION = 'L'.freeze

  def initialize(renderer: Renderer.new)
    @renderer = renderer
    @bitmap = []
  end

  def run(file)
    raise "Could not find file at #{file}" if file.nil? || !File.exist?(file)

    File.open(file).each_line do |line|
      execute_instruction(line)
    end
  end

  def execute_instruction(line)
    case extract_instruction(line)
    when INIT_INSTRUCTION
      @bitmap = @renderer.create_bitmap(init_instr_arguments(line))
    when SHOW_INSTRUCTION
      @renderer.show_bitmap(bitmap: @bitmap)
    when COLOR_INSTRUCTION
      @bitmap = @renderer.color_pixel(color_instr_arguments(line))
    else
      puts 'unrecognised command :('
    end
  end

  private

  def extract_instruction(line)
    line.chomp[0]
  end

  def init_instr_arguments(line)
    height = line.split[2].to_i
    width = line.split[1].to_i
    { height: height, width: width }
  end

  def color_instr_arguments(line)
    x = line.split[1].to_i
    y = line.split[2].to_i
    color = line.split[3]
    { x: x, y: y, color: color, bitmap: @bitmap.dup }
  end
end

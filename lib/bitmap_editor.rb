require 'renderer.rb'

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
      height = line.split(' ')[2].to_i
      width = line.split(' ')[1].to_i
      @bitmap = @renderer.create_bitmap(height: height, width: width)
    when SHOW_INSTRUCTION
      @renderer.show_bitmap(bitmap: @bitmap)
    when COLOR_INSTRUCTION
      x = line.split(' ')[1].to_i
      y = line.split(' ')[2].to_i
      color = line.split(' ')[3]
      @bitmap = @renderer.color_pixel(x: x, y: y, color: color, image: @bitmap)
    else
      puts 'unrecognised command :('
    end
  end

  private

  def extract_instruction(line)
    line.chomp[0]
  end
end

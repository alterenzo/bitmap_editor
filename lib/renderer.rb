require_relative 'validators/renderer_input_validator.rb'
# Executes graphic operations on a bitmap
class Renderer
  include RendererInputValidator
  DEFAULT_MAX_HEIGHT = 250.freeze
  DEFAULT_MAX_WIDTH = 250.freeze
  WHITE = 'O'.freeze

  def initialize(max_height = DEFAULT_MAX_HEIGHT, max_width = DEFAULT_MAX_WIDTH)
    @max_height = max_height
    @max_width = max_width
  end

  def color_pixel(x:, y:, color:, bitmap:)
    validate_color_pixel_input(x, y, color, bitmap)
    bitmap[y - 1][x - 1] = color
    bitmap
  end

  def create_bitmap(height:, width:)
    validate_create_bitmap_input(height, width, @max_height, @max_width)
    Array.new(height) { Array.new(width, WHITE) }
  end

  def show_bitmap(bitmap:)
    validate_bitmap(bitmap)
    bitmap.each { |row| puts row.join }
  end

  def horizontal_line(row:, x1:, x2:, color:, bitmap:)
    validate_horizontal_line_input(row, x1, x2, color, bitmap)
    bitmap[row - 1].fill(color, (x1 - 1)..(x2 - 1))
    bitmap
  end

  def vertical_line(column:, y1:, y2:, color:, bitmap:)
    validate_vertical_line_input(column, y1, y2, color, bitmap)
    horizontal_line(row: column, x1: y1, x2: y2,
                    color: color, bitmap: bitmap.transpose).transpose
  end

  def clear(bitmap:)
    validate_bitmap(bitmap)
    bitmap.map do |row|
      row.map { |pixel| WHITE }
    end
  end
end

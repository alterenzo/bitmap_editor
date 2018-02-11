# Executes graphic operations on a bitmap
class Renderer
  MAX_HEIGHT = 250.freeze
  MAX_WIDTH = 250.freeze
  WHITE = 'O'.freeze

  def color_pixel(x:, y:, color:, bitmap:)
    validate_color_pixel_input(x, y, color, bitmap)
    bitmap[y - 1][x - 1] = color
    bitmap
  end

  def create_bitmap(height:, width:)
    validate_create_bitmap_input(height, width)
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

  private

  def validate_create_bitmap_input(height, width)
    raise 'Dimensions must be bigger than 0' if height < 1 || width < 1
    raise "Dimesions are limited to #{MAX_WIDTH} x #{MAX_HEIGHT}" if height > MAX_HEIGHT || width > 250
  end

  def validate_bitmap(bitmap)
    raise 'The bitmap cannot be empty' if bitmap.nil? || bitmap.empty?
  end

  def validate_color_pixel_input(x, y, color, bitmap)
    validate_bitmap(bitmap)
    raise 'The provided coordinates are out of bounds' if x_out_of_bounds?(x, bitmap) || y_out_of_bounds?(y, bitmap)
  end

  def validate_horizontal_line_input(row, x1, x2, color, bitmap)
    validate_bitmap(bitmap)
    validate_range(x1, x2)
    raise 'The row number is out of bounds' if y_out_of_bounds?(row, bitmap)
    raise 'The X coordinates are out of bounds' if x_out_of_bounds?(x1, bitmap) || x_out_of_bounds?(x2, bitmap)
  end

  def validate_vertical_line_input(column, y1, y2, color, bitmap)
    validate_bitmap(bitmap)
    validate_range(y1, y2)
    raise 'The column number is out of bounds' if x_out_of_bounds?(column, bitmap)
    raise 'The Y coordinates are out of bounds' if y_out_of_bounds?(y1, bitmap) || y_out_of_bounds?(y2, bitmap)
  end

  def validate_range(x1, x2)
    raise 'The first coordinate of the range must be smaller than the second' if x2 <= x1
  end

  def y_out_of_bounds?(y, bitmap)
    bitmap.length < y || y < 1
  end

  def x_out_of_bounds?(x, bitmap)
    bitmap[0].length < x || x < 1
  end
end

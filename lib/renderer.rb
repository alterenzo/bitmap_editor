# Executes graphic operations on a bitmap
class Renderer
  WHITE = 'O'.freeze

  def color_pixel(x:, y:, color:, bitmap:)
    raise 'The bitmap cannot be empty' if bitmap.empty?
    raise 'The provided coordinates are out of bounds' if out_of_bounds?(x, y, bitmap)
    bitmap[y - 1][x - 1] = color
    bitmap
  end

  def create_bitmap(height:, width:)
    Array.new(height) { Array.new(width, WHITE) }
  end

  def show_bitmap(bitmap:)
    raise 'There is not image to show yet' if bitmap.nil? || bitmap.empty?
    bitmap.each { |row| puts row.join }
  end

  def horizontal_line(row:, x1:, x2:, color:, bitmap:)
    bitmap[row - 1].fill(color, (x1 - 1)..(x2 - 1))
    bitmap
  end

  def vertical_line(column:, y1:, y2:, color:, bitmap:)
    transposed = bitmap.transpose
    horizontal_line(row: column, x1: y1, x2: y2,
                    color: color, bitmap: transposed)
                    .transpose
  end

  private

  def out_of_bounds?(x, y, bitmap)
    bitmap.length < y || bitmap[0].length < x || x < 1 || y < 1
  end

end

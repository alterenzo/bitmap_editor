# Executes graphic operations on a bitmap
class Renderer
  WHITE = 'O'.freeze

  def color_pixel(x:, y:, color:, bitmap:)
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
end

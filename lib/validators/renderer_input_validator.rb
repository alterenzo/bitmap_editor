require_relative '../errors/renderer_error.rb'

module RendererInputValidator
  def validate_create_bitmap_input(height, width, max_height, max_width)
    if height < 1 || width < 1 || height > max_height || width > max_width
      raise RendererError.new("Dimensions must be positive,"\
        " bigger than 0"\
        " and within a max width of #{max_width}"\
        " and a max height of #{max_height}" )
    end
  end

  def validate_color(color)
    unless (color.instance_of?(String) &&
        color.length == 1 &&
        color.upcase == color)
      raise RendererError.new('Color must be represented by' \
        ' an uppercase string containing one character')
    end
  end

  def validate_bitmap(bitmap)
    if bitmap.nil? || bitmap.empty?
      raise RendererError.new('Bitmap cannot be empty')
    end
  end

  def validate_color_pixel_input(x, y, color, bitmap)
    validate_bitmap(bitmap)
    validate_color(color)
    if x_out_of_bounds?(x, bitmap) || y_out_of_bounds?(y, bitmap)
      raise RendererError.new('Coordinates are out of bounds')
    end
  end

  def validate_horizontal_line_input(row, x1, x2, color, bitmap)
    validate_bitmap(bitmap)
    validate_range(x1, x2)
    validate_color(color)
    if (y_out_of_bounds?(row, bitmap) ||
        x_out_of_bounds?(x1, bitmap) ||
        x_out_of_bounds?(x2, bitmap))
      raise RendererError.new('Coordinates are out of bounds')
    end
  end

  def validate_vertical_line_input(column, y1, y2, color, bitmap)
    validate_bitmap(bitmap)
    validate_range(y1, y2)
    validate_color(color)
    if (x_out_of_bounds?(column, bitmap) ||
        y_out_of_bounds?(y1, bitmap) ||
        y_out_of_bounds?(y2, bitmap))
      raise RendererError.new('Coordinates are out of bounds')
    end
  end

  def validate_range(x1, x2)
    raise RendererError.new('Invalid coordinates range') if x2 <= x1
  end

  private

  def y_out_of_bounds?(y, bitmap)
    bitmap.length < y || y < 1
  end

  def x_out_of_bounds?(x, bitmap)
    bitmap[0].length < x || x < 1
  end
end

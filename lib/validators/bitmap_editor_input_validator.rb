require_relative '../ext/string.rb'
require_relative '../errors/invalid_input_error.rb'

module BitmapEditorInputValidator
  def validate_init_instruction(instr)
    validate_number_of_elements(instr, 3)
    validate_coordinates(instr.split[1,2])
  end

  def validate_color_pixel_instruction(instr)
    validate_number_of_elements(instr, 4)
    validate_coordinates(instr.split[1,2])
  end

  def validate_horizontal_line_instruction(instr)
    validate_number_of_elements(instr, 5)
    validate_coordinates(instr.split[1,3])
  end

  def validate_vertical_line_instruction(instr)
    validate_horizontal_line_instruction(instr)
  end

  private

  def validate_number_of_elements(instr, length)
    raise InvalidInputError.new("The instruction must only contain #{length} elements") if instr.split.length != length
  end

  def validate_coordinates(coordinates)
    raise InvalidInputError.new('The coordinates must be integers') unless all_integers?(coordinates)
    raise InvalidInputError.new('Coordinates must be > 1') unless all_bigger_than_one?(coordinates)
  end

  def all_integers?(strings)
    strings.all? { |string| string.is_i? }
  end

  def all_bigger_than_one?(coordinates)
    coordinates.all? { |coordinate| coordinate.to_i > 0 }
  end
end

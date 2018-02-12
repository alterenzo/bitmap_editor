require_relative '../ext/string.rb'
require_relative '../errors/invalid_input_error.rb'

module BitmapEditorInputValidator

  def validate_init_instruction(instr)
    raise InvalidInputError.new('The init instruction must only contain 3 elements') if instr.split.length != 3
    raise InvalidInputError.new('The dimensions must be integers') unless instr.split[1].is_i? && instr.split[2].is_i?
    raise InvalidInputError.new('Dimensions must be > 1') unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0
  end

  def validate_color_pixel_instruction(instr)
    raise InvalidInputError.new('The init instruction must only contain 4 elements') if instr.split.length != 4
    raise InvalidInputError.new('The coordinates must be integers') unless instr.split[1].is_i? && instr.split[2].is_i?
    raise InvalidInputError.new('Coordinates must be > 1') unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0
  end

  def validate_horizontal_line_instruction(instr)
    raise InvalidInputError.new('The init instruction must only contain 5 elements') if instr.split.length != 5
    raise InvalidInputError.new('The coordinates must be integers') unless instr.split[1].is_i? && instr.split[2].is_i? && instr.split[3].is_i?
    raise InvalidInputError.new('Coordinates must be > 1') unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0 && instr.split[3].to_i > 0
  end

  def validate_vertical_line_instruction(instr)
    validate_horizontal_line_instruction(instr)
  end

end

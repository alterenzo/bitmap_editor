require_relative '../ext/string.rb'

module BitmapEditorInputValidator

  def validate_init_instruction(instr)
    raise 'Invalid input' if instr.split.length != 3
    raise 'Invalid input' unless instr.split[1].is_i? && instr.split[2].is_i?
    raise 'Invalid input' unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0
  end

  def validate_color_pixel_instruction(instr)
    raise 'Invalid input' if instr.split.length != 4
    raise 'Invalid input' unless instr.split[1].is_i? && instr.split[2].is_i?
    raise 'Invalid input' unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0
  end

  def validate_horizontal_line_instruction(instr)
    raise 'Invalid input' if instr.split.length != 5
    raise 'Invalid input' unless instr.split[1].is_i? && instr.split[2].is_i? && instr.split[3].is_i?
    raise 'Invalid input' unless instr.split[1].to_i > 0 && instr.split[2].to_i > 0 && instr.split[3].to_i > 0
  end

  def validate_vertical_line_instruction(instr)
    validate_horizontal_line_instruction(instr)
  end

end

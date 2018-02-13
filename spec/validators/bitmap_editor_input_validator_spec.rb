require 'validators/bitmap_editor_input_validator.rb'

describe BitmapEditorInputValidator do
  let(:validator) { Class.new { extend BitmapEditorInputValidator } }

  describe '#validate_init_instruction' do
    it 'does not raise an error with the correct input' do
      expect{ validator.validate_init_instruction('I 3 4') }
        .not_to raise_error
    end

    it 'raises an error if the instruciton has more than 3 elements' do
      expect{ validator.validate_init_instruction('I 3 4 5') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if the instruciton has less than 3 elements' do
      expect{ validator.validate_init_instruction('I 3 4 5') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not integers' do
      expect{ validator.validate_init_instruction('I 3 D') }
        .to raise_error(InvalidInputError)

      expect{ validator.validate_init_instruction('I E 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not positive' do
      expect{ validator.validate_init_instruction('I -4 3') }
        .to raise_error(InvalidInputError)
    end
  end

  describe '#validate_color_pixel_instruction' do
    it 'does not raise an error with the correct input' do
      expect{ validator.validate_color_pixel_instruction('I 3 4 C') }
        .not_to raise_error
    end

    it 'raises an error if the instruciton has more than 4 elements' do
      expect{ validator.validate_color_pixel_instruction('I 3 4 5 6') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if the instruciton has less than 4 elements' do
      expect{ validator.validate_color_pixel_instruction('I 3 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not integers' do
      expect{ validator.validate_color_pixel_instruction('I A 3 D') }
        .to raise_error(InvalidInputError)

      expect{ validator.validate_color_pixel_instruction('I 4 A 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not positive' do
      expect{ validator.validate_color_pixel_instruction('I -4 3 A') }
        .to raise_error(InvalidInputError)
    end
  end

  describe '#validate_horizontal_line_instruction' do
    it 'does not raise an error with the correct input' do
      expect{ validator.validate_horizontal_line_instruction('I 3 4 5 C') }
        .not_to raise_error
    end

    it 'raises an error if the instruciton has more than 5 elements' do
      expect{ validator.validate_horizontal_line_instruction('I 3 4 5 4 C') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if the instruciton has less than 5 elements' do
      expect{ validator.validate_horizontal_line_instruction('I 3 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not integers' do
      expect{ validator.validate_horizontal_line_instruction('I A 3 D D') }
        .to raise_error(InvalidInputError)

      expect{ validator.validate_horizontal_line_instruction('I 4 A 3 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not positive' do
      expect{ validator.validate_horizontal_line_instruction('I -4 3 5 A') }
        .to raise_error(InvalidInputError)
    end
  end

  describe '#validate_vertical_line_instruction' do
    it 'does not raise an error with the correct input' do
      expect{ validator.validate_vertical_line_instruction('I 3 4 5 C') }
        .not_to raise_error
    end

    it 'raises an error if the instruciton has more than 5 elements' do
      expect{ validator.validate_vertical_line_instruction('I 3 4 5 4 C') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if the instruciton has less than 5 elements' do
      expect{ validator.validate_vertical_line_instruction('I 3 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not integers' do
      expect{ validator.validate_vertical_line_instruction('I A 3 D D') }
        .to raise_error(InvalidInputError)

      expect{ validator.validate_vertical_line_instruction('I 4 A 3 4') }
        .to raise_error(InvalidInputError)
    end

    it 'raises an error if coordinates are not positive' do
      expect{ validator.validate_vertical_line_instruction('I -4 3 5 A') }
        .to raise_error(InvalidInputError)
    end
  end
end

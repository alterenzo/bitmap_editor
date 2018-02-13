require 'validators/renderer_input_validator.rb'

describe RendererInputValidator do
  let(:validator) { Class.new { extend RendererInputValidator } }
  let(:bitmap) { Array.new(5) { Array.new(6, "O") } }

  describe '#validate_create_bitmap_input' do
    it 'raises an error if dimensions are < 1' do
      expect{ validator.validate_create_bitmap_input(0, 1, 250, 250) }
        .to raise_error RendererError
    end

    it 'raises an error if dimensions are larger than allowed' do
      expect{ validator.validate_create_bitmap_input(4, 5, 2, 2) }
        .to raise_error RendererError
    end

    it 'does not raise exception in case of valid input' do
      expect{ validator.validate_create_bitmap_input(2, 1, 250, 250) }
        .not_to raise_error
    end
  end

  describe '#validate_color_pixel_input' do
    before(:each) do
      allow(validator).to receive(:validate_bitmap)
      allow(validator).to receive(:validate_color)
    end

    it 'does not raise exception in case of valid input' do
      expect{ validator.validate_color_pixel_input(2, 1, 'C', bitmap) }
        .not_to raise_error
    end

    it 'raises an error if coords are out of bounds' do
      expect{ validator.validate_color_pixel_input(3, 6, 'C', bitmap) }
        .to raise_error RendererError
    end

    it 'validates the bitmap' do
      expect(validator).to receive(:validate_bitmap).with(bitmap)

      validator.validate_color_pixel_input(1, 2, 'C', bitmap)
    end

    it 'validates the color' do
      expect(validator).to receive(:validate_color).with('C')

      validator.validate_color_pixel_input(1, 2, 'C', bitmap)
    end
  end

  describe '#validate_vertical_line_input' do
    before(:each) do
      allow(validator).to receive(:validate_bitmap)
      allow(validator).to receive(:validate_color)
      allow(validator).to receive(:validate_range)
    end

    it 'validates the bitmap' do
      expect(validator).to receive(:validate_bitmap).with(bitmap)

      validator.validate_vertical_line_input(1, 1, 2, 'C', bitmap)
    end

    it 'validates the color' do
      expect(validator).to receive(:validate_color).with('C')

      validator.validate_vertical_line_input(1, 1, 2, 'C', bitmap)
    end

    it 'validates the range' do
      expect(validator).to receive(:validate_range).with(2, 3)

      validator.validate_vertical_line_input(1, 2, 3, 'C', bitmap)
    end

    it 'raises an error if the coordinates are out of bounds' do
      expect{ validator.validate_vertical_line_input(10, 1, 2, 'C', bitmap) }
        .to raise_error RendererError
      expect{ validator.validate_vertical_line_input(1, 2, 20, 'C', bitmap) }
        .to raise_error RendererError
      expect{ validator.validate_vertical_line_input(1, 15, 20, 'C', bitmap) }
        .to raise_error RendererError
    end
  end

  describe '#validate_horizontal_line_input' do
    before(:each) do
      allow(validator).to receive(:validate_bitmap)
      allow(validator).to receive(:validate_color)
      allow(validator).to receive(:validate_range)
    end

    it 'validates the bitmap' do
      expect(validator).to receive(:validate_bitmap).with(bitmap)

      validator.validate_horizontal_line_input(1, 1, 2, 'C', bitmap)
    end

    it 'validates the color' do
      expect(validator).to receive(:validate_color).with('C')

      validator.validate_horizontal_line_input(1, 1, 2, 'C', bitmap)
    end

    it 'validates the range' do
      expect(validator).to receive(:validate_range).with(2, 3)

      validator.validate_horizontal_line_input(1, 2, 3, 'C', bitmap)
    end

    it 'raises an error if the coordinates are out of bounds' do
      expect{ validator.validate_horizontal_line_input(10, 1, 2, 'C', bitmap) }
        .to raise_error RendererError
      expect{ validator.validate_horizontal_line_input(1, 2, 20, 'C', bitmap) }
        .to raise_error RendererError
      expect{ validator.validate_horizontal_line_input(1, 15, 20, 'C', bitmap) }
        .to raise_error RendererError
    end
  end

  describe '#validate_range' do
    it 'raises an error if coordinates are not in increasing order' do
      expect{ validator.validate_range(3, 1) }.to raise_error RendererError
    end

    it 'raises an error if coordinates are equals' do
      expect{ validator.validate_range(1, 1) }.to raise_error RendererError
    end
  end

  describe '#validate_bitmap' do
    it 'raise and error if the bitmap is empty' do
      bitmap = []
      expect{ validator.validate_bitmap bitmap }.to raise_error RendererError
    end

    it 'raise and error if the bitmap is nil' do
      bitmap = nil
      expect{ validator.validate_bitmap bitmap }.to raise_error RendererError
    end
  end

  describe '#validate_color' do
    it 'raises an error if the color is not a string' do
      expect{ validator.validate_color(1) }.to raise_error RendererError
    end

    it 'raises an error if the color has more than one character' do
      expect{ validator.validate_color('HI') }.to raise_error RendererError
    end

    it 'raises an error if the color is not uppercase' do
      expect{ validator.validate_color('c') }.to raise_error RendererError
    end
  end
end

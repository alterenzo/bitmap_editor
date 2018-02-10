require 'renderer.rb'

describe Renderer do

  subject(:renderer) { described_class.new }

  describe '#create_bitmap' do
    it 'creates a two dimensional array with given height and width' do
      width = rand(1..5)
      height = rand(1..5)

      result = renderer.create_bitmap(height: height, width: width)

      expect(result.length).to eq height
      expect(result[0].length).to eq width
    end

    it 'fills the newly created bitmap with white' do
      bitmap = renderer.create_bitmap(height: 2, width: 2)

      expect(bitmap.flatten.all? { |color| color.equal? Renderer::WHITE })
        .to be true
    end
  end

  describe '#show_bitmap' do
    it 'raises an error if there is no bitmap to show' do
      bitmap = []

      expect { renderer.show_bitmap(bitmap: bitmap) }
        .to raise_error('There is not image to show yet')
    end

    it 'prints a representation of the bitmap to the standard output' do
      bitmap = Array.new(2, Array.new(2, Renderer::WHITE))
      expect { renderer.show_bitmap(bitmap: bitmap) }
        .to output("OO\nOO\n").to_stdout
    end
  end

  describe '#color_pixel' do
    it 'colors a pixel at given coordinates on the given bitmal' do
      bitmap = Array.new(4, Array.new(4, Renderer::WHITE))

      result = renderer.color_pixel(x: 1, y: 2, color: 'C', bitmap: bitmap)

      expect(result[1][0]).to eq 'C'
    end
  end
end

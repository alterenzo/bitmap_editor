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
    it 'colors a pixel at given coordinates on the given bitmap' do
      bitmap = Array.new(3) { Array.new(3, Renderer::WHITE) }

      result = renderer.color_pixel(x: 1, y: 2, color: 'C', bitmap: bitmap)

      expect(result).to eq [["O", "O", "O"], ["C", "O", "O"], ["O", "O", "O"]]
    end

    it 'raises an exception if the coordinates are out of bounds' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect { renderer.color_pixel(x: 5, y: 3, color: 'C', bitmap: bitmap) }
        .to raise_error('The provided coordinates are out of bounds')
    end

    it 'raises an exception if the bitmap is empty' do
      bitmap = []

      expect { renderer.color_pixel(x: 5, y: 3, color: 'C', bitmap: bitmap) }
        .to raise_error('The bitmap cannot be empty')
    end
  end

  describe '#horizontal_line' do
    it 'draws an horizontal line on the bitmap' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      result = renderer.horizontal_line(row: 2, x1: 2, x2: 4, color: 'C', bitmap: bitmap)

      expect(result).to eq [["O", "O", "O", "O"], ["O", "C", "C", "C"],
                            ["O", "O", "O", "O"], ["O", "O", "O", "O"]]
    end

    it 'draws an horizontal line on the bitmap on non-white pixels' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      bitmap = renderer.horizontal_line(row: 2, x1: 2, x2: 4, color: 'C', bitmap: bitmap)
      result = renderer.horizontal_line(row: 2, x1: 1, x2: 3, color: 'A', bitmap: bitmap)

      expect(result).to eq [["O", "O", "O", "O"], ["A", "A", "A", "C"],
                            ["O", "O", "O", "O"], ["O", "O", "O", "O"]]
    end
  end

  describe '#vertical_line' do
    it 'draws a vertical line on the bitmap' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      result = renderer.vertical_line(column: 2, y1: 2, y2: 4, color: 'C', bitmap: bitmap)

      expect(result).to eq [["O", "O", "O", "O"], ["O", "C", "O", "O"],
                          ["O", "C", "O", "O"], ["O", "C", "O", "O"]]
    end

    it 'draws a vertical line on the bitmap on non-white pixels' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      bitmap = renderer.vertical_line(column: 2, y1: 2, y2: 4, color: 'C', bitmap: bitmap)
      result = renderer.vertical_line(column: 2, y1: 1, y2: 3, color: 'B', bitmap: bitmap)
      expect(result).to eq [["O", "B", "O", "O"], ["O", "B", "O", "O"],
                            ["O", "B", "O", "O"], ["O", "C", "O", "O"]]
    end
  end
end

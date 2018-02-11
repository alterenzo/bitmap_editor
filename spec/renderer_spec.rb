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

    it "will not create a bitmap with height > #{Renderer::MAX_HEIGHT}" do
      expect{ renderer.create_bitmap(height: 251, width: 5) }
        .to raise_error "Dimesions are limited to #{Renderer::MAX_WIDTH} x #{Renderer::MAX_HEIGHT}"
    end

    it "will not create a bitmap with width > #{Renderer::MAX_WIDTH}" do
      expect{ renderer.create_bitmap(height: 25, width: 251) }
        .to raise_error "Dimesions are limited to #{Renderer::MAX_WIDTH} x #{Renderer::MAX_HEIGHT}"
    end

    it 'raises an error if height < 1' do
      expect{ renderer.create_bitmap(height: 0, width: 5) }
        .to raise_error 'Dimensions must be bigger than 0'
    end

    it 'raises an error if width < 1' do
      expect{ renderer.create_bitmap(height: 2, width: -1) }
        .to raise_error 'Dimensions must be bigger than 0'
    end

    it 'fills the newly created bitmap with white' do
      bitmap = renderer.create_bitmap(height: 250, width: 250)

      expect(bitmap.flatten.all? { |color| color.equal? Renderer::WHITE })
        .to be true
    end
  end

  describe '#show_bitmap' do
    it 'raises an error if there is no bitmap to show' do
      bitmap = []

      expect { renderer.show_bitmap(bitmap: bitmap) }
        .to raise_error('The bitmap cannot be empty')
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

    it 'raises an error if the bitmap is nil' do
      bitmap = nil

      expect{ renderer.color_pixel(x: 1, y: 2, color: 'C', bitmap: bitmap) }
        .to raise_error 'The bitmap cannot be empty'
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

    it 'raises an exception if x < 1' do
      bitmap = Array.new(1) { Array.new(1, Renderer::WHITE) }

      expect { renderer.color_pixel(x: 0, y: 3, color: 'C', bitmap: bitmap) }
        .to raise_error('The provided coordinates are out of bounds')
    end

    it 'raises an exception if y < 1' do
      bitmap = Array.new(1) { Array.new(1, Renderer::WHITE) }

      expect { renderer.color_pixel(x: 5, y: -4, color: 'C', bitmap: bitmap) }
        .to raise_error('The provided coordinates are out of bounds')
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

    it 'raises an error if "row" is out of bounds' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.horizontal_line(row: 5, x1: 2, x2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The row number is out of bounds'
    end

    it 'raises an error if the bitmap is empty' do
      bitmap = []

      expect{ renderer.horizontal_line(row: 5, x1: 2, x2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The bitmap cannot be empty'
    end

    it 'raises an error if the bitmap is nil' do
      bitmap = nil

      expect{ renderer.horizontal_line(row: 5, x1: 2, x2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The bitmap cannot be empty'
    end

    it 'raises an error if x1 > x2' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.horizontal_line(row: 2, x1: 3, x2: 2, color: 'C', bitmap: bitmap) }
        .to raise_error 'The first coordinate of the range must be smaller than the second'
    end

    it 'raises an error if x1 == x2' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.horizontal_line(row: 2, x1: 2, x2: 2, color: 'C', bitmap: bitmap) }
        .to raise_error 'The first coordinate of the range must be smaller than the second'
    end

    it 'raises an error if the X coordinates are out of bounds' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.horizontal_line(row: 2, x1: 4, x2: 5, color: 'C', bitmap: bitmap) }
        .to raise_error 'The X coordinates are out of bounds'
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

    it 'raises an error if the bitmap is empty' do
      bitmap = []

      expect{ renderer.vertical_line(column: 5, y1: 2, y2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The bitmap cannot be empty'
    end

    it 'raises an error if the bitmap is nil' do
      bitmap = nil

      expect{ renderer.vertical_line(column: 5, y1: 2, y2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The bitmap cannot be empty'
    end

    it 'raises an error if "column" is out of bounds' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.vertical_line(column: 5, y1: 2, y2: 4, color: 'C', bitmap: bitmap) }
        .to raise_error 'The column number is out of bounds'
    end

    it 'raises an error if y1 > y2' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.vertical_line(column: 2, y1: 3, y2: 2, color: 'C', bitmap: bitmap) }
        .to raise_error 'The first coordinate of the range must be smaller than the second'
    end

    it 'raises an error if y1 == y2' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.vertical_line(column: 2, y1: 2, y2: 2, color: 'C', bitmap: bitmap) }
        .to raise_error 'The first coordinate of the range must be smaller than the second'
    end

    it 'raises an error if the Y coordinates are out of bounds' do
      bitmap = Array.new(4) { Array.new(4, Renderer::WHITE) }

      expect{ renderer.vertical_line(column: 2, y1: 4, y2: 5, color: 'C', bitmap: bitmap) }
        .to raise_error 'The Y coordinates are out of bounds'
    end
  end
end

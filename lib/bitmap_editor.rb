class BitmapEditor

  WHITE = "O"

  def run(file)
    raise "Could not find file at #{file}" if file.nil? || !File.exists?(file)

    File.open(file).each_line do |line|
      line = line.chomp
      case line[0]
      when 'I'
        height = line.split(' ')[2].to_i
        width = line.split(' ')[1].to_i
        self.bitmap = create_bitmap(height: height, width: width)
      when 'S'
        show_bitmap(bitmap: bitmap)
      else
          puts 'unrecognised command :('
      end
    end
  end

  def create_bitmap(height:, width:)
    Array.new(height, Array.new(width, WHITE))
  end

  def show_bitmap(bitmap:)
    raise "There is not image to show yet" if bitmap.nil? || bitmap.empty?
    bitmap.each { |row| puts row.join }
  end

  private

  attr_accessor :bitmap

end

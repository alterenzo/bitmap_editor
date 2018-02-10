class BitmapEditor

  attr_reader :bitmap

  def run(file)
    raise "Could not find file at #{file}" if file.nil? || !File.exists?(file)

    File.open(file).each_line do |line|
      line = line.chomp
      case line[0]
      when 'I'
        heigth = line.split(' ')[2].to_i
        width = line.split(' ')[1].to_i
        @bitmap = Array.new(heigth, Array.new(width, "O"))
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end
end

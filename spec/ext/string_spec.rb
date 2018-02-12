require 'ext/string.rb'

describe String do
  describe '#is_i?' do
    it 'returns true if the string represents an integer' do
      integer_string = '34'

      expect(integer_string.is_i?).to be true
    end

    it 'returns false if the string does not represent an integer' do
      string = 'hello'

      expect(string.is_i?).to be false
    end

    it 'returns false if the string represents a float' do
      float_string = '3.4'

      expect(float_string.is_i?).to be false
    end
  end
end

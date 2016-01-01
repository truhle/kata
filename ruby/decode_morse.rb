# Decodes a message from a string of bits where a dot can be represented
# by one or more 1s.  The lengths of the bit representations has some
# potenetial for error (eg 1 or 3 1s for a two 1 dot).  Where there is
# unclarity about whether a given set of 1s represent a dot or dash, a dot is assumed.
# The message decoder relies on a MORSE_CODE dictionary that is not included.

def decodeBits(bits)
  bits = bits.gsub(/^0+|0+$/, '').scan(/0+|1+/)
  rate = bits.min_by { |el| el.length }.length
  rate += 1 if bits.any? { |el| el.length / rate > 1 && el.length / rate <= 2 }

  bits.map do |bit|
    bit_length = (bit.length / rate).ceil
    p bit_length
    bit_value = bit[0];
    if bit_length <= 2
      bit_value == '1' ? '.' : ''
    elsif bit_length == 3
      bit_value == '1' ? '-' : ' '
    elsif bit_length == 7 && bit_value == '0'
      '   '
    end
  end.join('')
end

def decodeMorse(morseCode)
   morseCode.strip.split('   ').map {|m_word| m_word.split(' ').map {|m_char| MORSE_CODE[m_char] }.join }.join(' ')
end

p decodeBits('0100110011001100000011000000111111001100111111001111110000000000000011001111110011111100111111000000110011001111110000001111110011001100000011')
# => ".... . -.--   .--- ..- -.. ."

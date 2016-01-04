# Given a string of all digits of a given base, from zero to last,
# and a similar string of the desired base, returns the converted value.

def convert(input, source, target)
  input = input.reverse.split('')

  mult = source.length
  div = target.length

  base10_val = input.map.with_index { |c, i| source.index(c) * (mult ** i) }.reduce(:+)

  base_target = (0..find_place(base10_val, div)).to_a.reverse.map do |n|
    index = base10_val / (div ** n)
    base10_val %= (div ** n)
    target[index]
  end.join
end

def find_place(number, div)
  i = 0
  i += 1 until number / (div ** i).to_f  < div
  i
end



bin='01'
oct='01234567'
dec='0123456789'
hex='0123456789abcdef'
allow='abcdefghijklmnopqrstuvwxyz'
alup='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
alpha='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
alphanum='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

p convert("1010", bin, dec)
# => "10"
p convert('todd', alphanum, dec)
# => "7004587"
p convert(convert('todd', alphanum, dec), dec, alphanum)
# => "todd"

# A more elegant approach

def elegant_convert(input, source, target)
  value = input.chars.reduce(0) do |s, c|
    source.size * s + source.index(c)
  end
  res = ''
  while value >= 0
    res = target[value % target.size] + res
    value = value < target.size ? -1 : value/target.size
  end
  res
end

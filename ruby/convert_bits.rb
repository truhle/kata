# Determines the number of "1"s in binary representations
# of two numbers that are not shared.

def convertBits(a,b)
  str1 = a.to_s(2)
  str2 = b.to_s(2)
  ary1 = equalAry(str1, str2)
  p ary1
  ary2 = equalAry(str2, str1)
  p ary2
  ary1.reject.with_index { |el, i| el == ary2[i] }.size
end

def equalAry(str1, str2)
  str1.rjust(str2.length, "0").chars
end

p convertBits(31, 14)
# => 2


# A much more succinct approach

def concise_convert_bits(a,b)
  (a ^ b).to_s(2).scan(/1/).size
end

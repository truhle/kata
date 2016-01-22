def solution(roman, total = 0)
  values = {"I" => 1, "V" => 5, "X" => 10, "L" => 50,
            "C" => 100, "D" => 500, "M" => 1000}
  total += check_next_ups(roman) ? -values[roman[0]] : values[roman[0]]
  roman.length > 1 ? solution(roman.slice(1..-1), total) : total
end

def check_next_ups(str)
  next_ups = {"I" => ["V", "X"], "V" => [], "X" => ["L", "C"], "L" => [],
              "C" => ["D", "M"], "D" => [], "M" => []}
  char, next_char = str[0], str[1]
  next_ups[char].include?(next_char)
end

p solution("XIV")
#=> 14

# An interesting, more concise approach that creates an ordered Regexp and
# uses that to split the string into an array and do an inject that produces
# the sum 

ROMAN = {
  'M' => 1000, 'CM' => 900, 'D' => 500, 'CD' => 400, 'C' => 100,
  'XC' => 90, 'L' => 50, 'XL' => 40, 'X' => 10,
  'IX' => 9, 'V' => 5, 'IV' => 4, 'I' => 1
}

def intr_solution(roman)
  re = Regexp.new(ROMAN.keys.join('|'))
  roman.scan(re).inject(0) do |number, key|
    number + ROMAN[key]
  end
end

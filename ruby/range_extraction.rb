 # takes a list of integers in increasing order and returns a comma separated
 # string of integers, with sequences of consecutive integers longer than
 # 2 condensed to a "range" separated by a dash (e.g. "3-9")

def solution(list)
  res = ""
  i = 0
  while i < list.length
    range_end = return_range_end(list, i)
    res += range_end > i ? "#{list[i]}-#{list[range_end]}," : "#{list[i]},"
    i = range_end + 1
  end
  res.slice(0..-2)
end

def return_range_end(list, i)
  value, range_cut = list[i], 2
  return i unless list[i + range_cut] && list[i + range_cut] - value == range_cut
  last_i = i + range_cut
  loop do
    next_i = last_i + 1
    if list[next_i] && list[next_i] - value == next_i - i
      last_i = next_i
    else
      return last_i
    end
  end
end

p solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20])
# => "0,-3-1,3-5,7-11,14,15,17-20"

# from the Ruby Docs...  Utilizing the power of Enuemrable#slice_before

a = [0, 2, 3, 4, 6, 7, 9]
prev = a[0]
p a.slice_before { |e|
  prev, prev2 = e, prev
  prev2 + 1 != e
}.map { |es|
  es.length <= 2 ? es.join(",") : "#{es.first}-#{es.last}"
}.join(",")
#=> "0,2-4,6,7,9"

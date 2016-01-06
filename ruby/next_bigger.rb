# Returns next bigger number formed from the same digits.  If no such next
# bigger number exists, returns -1.

def next_bigger(n)
  nums = n.to_s.split('').reverse
  1.upto(nums.length - 1) do |iterations|
    iterations.times do |index|
      if nums[index] > nums[iterations]
        nums[index], nums[iterations] = nums[iterations], nums[index]
        nums = nums.slice(0, iterations).sort.reverse + nums.slice(iterations..-1)
        return nums.reverse.join.to_i
      end
    end
  end
  -1
end


p next_bigger(12) #=> 21
p next_bigger(513) #=> 531
p next_bigger(2017) #=> 2071
p next_bigger(414) #=> 441
p next_bigger(144) #=> 414
p next_bigger(8374) #=> 8437
p next_bigger(1193335546853) #=> 1193335548356
p next_bigger(807280087732) #=> 807280203778

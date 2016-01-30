# Returns the nth Hamming number.  Solution adapted from
# rosettacode.org/wiki/Hamming_numbers#Ruby

def hamming(n)
  hamming_enum = Enumerator.new do |yielder|
    next_ham = 1
    queues = [[ 2, []], [3, []], [5, []] ]

    loop do
      yielder << next_ham   # or: yielder.yield(next_ham)

      queues.each {|m,queue| queue << next_ham * m}
      next_ham = queues.collect{|m,queue| queue.first}.min
      queues.each {|m,queue| queue.shift if queue.first==next_ham}
    end
  end

  hamming_enum.take(n).last
end

1.upto(20) { |i| p hamming(i) }
#=> 1
#=> 2
#=> 3
#=> 4
#=> 5
#=> 6
#=> 8
#=> 9
#=> 10
#=> 12
#=> 15
#=> 16
#=> 18
#=> 20
#=> 24
#=> 25
#=> 27
#=> 30
#=> 32
#=> 36

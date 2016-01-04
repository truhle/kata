# return a flat array representing the values of Pascal's Triangle to the n-th level

def pascalsTriangle(n)
  triangle = [];

  n.times do |i|
    if i == 0
      triangle << [1]
    elsif i == 1
      triangle << [1,1]
    else
      new_level = []
      (i + 1).times do |j|
        if j == 0 || j == i
          new_level << 1
        else
          prev_level = triangle[i - 1]
          new_level << (prev_level[j - 1] + prev_level[j])
        end
      end
      triangle << new_level
    end
  end

  triangle.flatten
end

# A much more concise approach, utlizing rescue to catch the exception
# generated by attempting to add 1 and nil, substituting 1 as the result.

def concise_pascals_triangle(n)
   (1..n).each_with_object([]) do |i, a|
     a << (1..i).map { |j| j == 1 ? 1 : (a.last[j-2] + a.last[j-1] rescue 1) }
   end.flatten
end

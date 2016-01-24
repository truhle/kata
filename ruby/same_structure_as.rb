# Compares the nesting structure of two arrays (no matter their values) and 
# returns a boolean


class Array
  def same_structure_as(ary)
    return false unless ary.class == Array
    self.make_zeroes == ary.make_zeroes
  end

  def make_zeroes
    self.reduce([]) do |a, v|
      if v.class == Array
        a << v.make_zeroes
      else
        a << 0
      end
    end
  end
end

# Calculates an array of layers of a Pascal triangle
# to a given depth.

def pascal(depth)
  triangle = []
  depth.times { |curr|
    layer = []
    (curr + 1).times { |n|
      if n == 0 || n == curr
        layer << 1
      else
        prev_layer = triangle.last
        layer << prev_layer[n - 1] + prev_layer[n]
      end
    }
    triangle << layer
  }

  triangle
end

p pascal(5)

# => [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]

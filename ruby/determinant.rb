# returns the determinant of a matrix

def determinant(matrix)
  width = matrix.length
  return matrix[0][0] if width == 1
  return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0] if width == 2
  matrix[0].each_with_index.reduce(0) do |sum, (el, i)|
    val = el * determinant(matrix_minor(i, matrix))
    i.even? ? sum + val : sum - val
  end
end

def matrix_minor(i, matrix)
  matrix.slice(1..-1).map { |row| row.slice(0...i) + row.slice((i + 1)..-1) }
end

m2 = [ [2,5,3],
       [1,-2,-1],
       [1, 3, 4]]

p matrix_minor(0, m2)
p matrix_minor(1, m2)
p matrix_minor(2, m2)

p

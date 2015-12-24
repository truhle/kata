# Eliminates adjacent opposite directions in an array
# until no more remain and returns an array of orthogonal
# adjacent directions.


def dirReduc(arr)
  new_arr = arr.dup

  arr.each_with_index {|d, i|
    if d == "NORTH" && new_arr[i+1] == "SOUTH"
      new_arr.slice!(i, 2)
      break
    elsif d == "SOUTH" && new_arr[i+1] == "NORTH"
      new_arr.slice!(i, 2)
      break
    elsif d == "EAST" && new_arr[i+1] == "WEST"
      new_arr.slice!(i, 2)
      break
    elsif d == "WEST" && new_arr[i+1] == "EAST"
      new_arr.slice!(i, 2)
      break
    end
  }
  if new_arr == arr
    new_arr
  else
    dirReduc(new_arr)
  end
end


a = ["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]

p dirReduc(a)

# => "WEST"

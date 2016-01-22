# Finds the only path through a rectangular or square 'mine', represented by
# an array of arrays of booleans.  False for walls, true for open path.  'Miner'
# is the starting point.  'Last' is the exit.  Maximum minemap size is 5 x 5.

def solve(minemap, miner, last)
  unresolved_paths = [[miner]]
  way_out = []
  return way_out if miner == last
  def search(minemap, unresolved_paths, last)
    path = unresolved_paths.shift
    miner = path[-1]
    options = return_options(minemap, miner, path)
    if options.include?(last)
      return path << last
    else
      options.each {|o| unresolved_paths << (path.map {|el| el} << o)}
    end
    search(minemap, unresolved_paths, last)
  end
  way_out = search(minemap, unresolved_paths, last)
  translate_directions(way_out)
end

def return_options(minemap, miner, path)
  options = []
  2.times do |i|
    xy = i == 0 ? "x" : "y"
    -1.step(1,2) do |n|
      if in_bounds?(minemap, miner, xy, n)
        new_miner = {}
        miner.each do |k,v|
          if k == xy
            new_miner[k] = miner[k] + n
          else
            new_miner[k] = miner[k]
          end
        end
        options << new_miner
      end
    end
  end
  options.reject { |o| path.include?(o) || !minemap[o["x"]][o["y"]] }
end

def in_bounds?(minemap, miner, xy, n)
  max = xy == "x" ? minemap.length : minemap[0].length
  if miner[xy] + n < 0
    return false
  elsif miner[xy] + n >= max
    return false
  end
  true
end

def translate_directions(path)
  directions = []
  path.each_with_index do |place, i|
    if i == 0
      next
    else
      diff = path[i].merge(path[i - 1]) { |k, oldval, newval| oldval - newval }.reject {|k,v| v == 0}
    end
    directions << find_direction(diff)
  end
  directions
end

def find_direction(diff)
  if diff.keys[0] == "x"
    diff.values[0] < 0 ? "left" : "right"
  else
    diff.values[0] < 0 ? "up" : "down"
  end
end


minemap1 = [[true, false],
    [true, true]]

p solve(minemap1, {'x'=>0,'y'=>0}, {'x'=>1,'y'=>0})
#=>["right"]

minemap2 = [[true, true, true],
  [false, false, true],
  [true, true, true]]

p solve(minemap2, {'x'=>0,'y'=>0}, {'x'=>2,'y'=>0})
#=>['down', 'down', 'right', 'right', 'up', 'up']


# A much more elegant and compact solution

def elegant_solve(minemap, miner, exit, from=nil)
  return [] if miner == exit
  {
    up: ['y', -1],
    down: ['y', 1],
    left: ['x', -1],
    right: ['x', 1],
  }.each { |k, (d, o)|
    pos = miner.dup
    pos[d] += o
    next if pos == from
    next if pos.values.any? { |v| v < 0 }
    next unless (minemap[pos['x']][pos['y']] rescue false)
    path = solve(minemap, pos, exit, miner)
    return [k.to_s] + path if path
  }
  nil
end

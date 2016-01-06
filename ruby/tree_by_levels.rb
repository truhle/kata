# return the array containing the tree levels, from root to last level.
def tree_by_levels(node)
  res = []
  return res if !node
  queue = {0 => [node]}
  level = 0

  while queue[level].length > 0
    node = queue[level].shift
    res << node.value
    up = level + 1
    queue[up] = [] unless queue[up]
    queue[up] << node.left if node.left
    queue[up] << node.right if node.right
    level += 1 if queue[level].length == 0 && queue[up].length > 0
  end

  res
end

class TreeNode
  attr_accessor :left
  attr_accessor :right
  attr_accessor :value
end

test_node = TreeNode.new
test_node.value = 1

p tree_by_levels(test_node)

# A more elegant solution.  The levels were not necessary.  That was an artifact
# of my earlier recursive solution.

def elegant_tree_by_levels(node)
  stack=[]
  stack.push node if node
  stack.each do |n|
    stack.push n.left if n.left
    stack.push n.right if n.right
  end
  stack.map! &:value
end

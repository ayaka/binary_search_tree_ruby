require_relative "node.rb"

class Tree
  attr_reader :root
  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  private
  def build_tree(arr, parent_node = nil)
    return if arr.length == 0
    middle_index = arr.length / 2
    node = Node.new(arr[middle_index])
    unless parent_node == nil
      parent_node.right_child = node if node >= parent_node
      parent_node.left_child = node if node < parent_node
    end
    build_tree(arr[0...middle_index], node)
    build_tree(arr[(middle_index + 1)..arr.length - 1], node)
    node
  end
end


# arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
# arr = [1, 2, 3, 4, 5, 6, 7]

tree = Tree.new(arr)

p tree.root
p tree.root.left_child.data
p tree.root.left_child.left_child.data
p tree.root.left_child.right_child.data
p tree.root.left_child.left_child.left_child.data

p tree.root.right_child.data
p tree.root.right_child.left_child.data
p tree.root.right_child.right_child.data
p tree.root.right_child.right_child.right_child.data

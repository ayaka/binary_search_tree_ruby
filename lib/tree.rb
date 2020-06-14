require_relative "node.rb"

class Tree
  attr_reader :root
  def initialize(arr)
    @root = build_tree(arr)
  end

  def insert(value)
    node = Node.new(value)
    parent_node = root
    loop do 
      if node == parent_node
        return
      elsif node < parent_node
        parent_node.left_child.nil? ? (return parent_node.left_child = node) : parent_node = parent_node.left_child
      else
        parent_node.right_child.nil? ? (return parent_node.right_child = node) : parent_node = parent_node.right_child
      end
    end
  end

  def delete(value)
    if value == root.data
      @root = link_descendant_node(root)
    else
      parent_node = find_parent_node(value)
      return if parent_node == nil
      if value < parent_node.data 
        node = parent_node.left_child
        parent_node.left_child = link_child_node(node)
      else
        node = parent_node.right_child
        parent_node.right_child = link_child_node(node)
      end
    end
  end

  def find(value)
    if value == root.data
      return root
    else
      parent_node = find_parent_node(value)
      return nil if parent_node == nil
      value < parent_node.data ? node = parent_node.left_child : node = parent_node.right_child
    end
  end

  def level_order(queue = [], value_arr = [])
    root.nil? ? return : queue << root
    queue.each do |node|
      queue << node.left_child if node.left_child
      queue << node.right_child if node.right_child
      block_given? ? yield(node) : value_arr << node.data
    end
    value_arr unless block_given?
  end

  # recursion version of level_order
  def level_order_r(queue = [root], value_arr = [], &block)
    current = queue.shift
    return if current.nil?
    queue << current.left_child if current.left_child
    queue << current.right_child if current.right_child
    block_given? ? yield(current) : value_arr << current.data
    level_order_r(queue, value_arr, &block)
    return value_arr unless block_given?
  end

  def inorder(current = root, value_arr = [], &block)
    return if current.nil?
    inorder(current.left_child, value_arr, &block) 
    block_given? ? yield(current) : value_arr << current.data
    inorder(current.right_child, value_arr, &block)  
    value_arr unless block_given?
  end

  def preorder(current = root, value_arr = [], &block)
    return if current.nil?
    block_given? ? yield(current) : value_arr << current.data
    preorder(current.left_child, value_arr, &block)
    preorder(current.right_child, value_arr, &block)
    value_arr unless block_given?
  end

  def postorder(current = root, value_arr = [], &block)
    return if current.nil?
    postorder(current.left_child, value_arr, &block)
    postorder(current.right_child, value_arr, &block)
    block_given? ? yield(current) : value_arr << current.data
  end

  def depth(current, current_level = -1, levels = [])
    if current.nil?
      levels << current_level
      return levels.max
    end
    current_level += 1
    depth(current.left_child, current_level, levels) 
    depth(current.right_child, current_level, levels)
  end

  def balanced?(root = @root)
    level_gap = depth(root.left_child) - depth(root.right_child)
    return false if level_gap > 1 || level_gap < -1
    true
  end

  def rebalance!
    @root = build_tree(level_order)
  end

  private
  def build_tree(arr, parent_node = nil)
    return if arr.length == 0
    arr = arr.uniq.sort
    middle_index = arr.length / 2
    node = Node.new(arr[middle_index])
    unless parent_node.nil?
      parent_node.right_child = node if node >= parent_node
      parent_node.left_child = node if node < parent_node
    end
    node.left_child = build_tree(arr[0...middle_index], node)
    node.right_child = build_tree(arr[(middle_index + 1)..arr.length - 1], node)
    node
  end

  def nil.data
    nil
  end

  def find_parent_node(value, parent_node = root)
    return if parent_node == nil || parent_node.leaf?
    return parent_node if parent_node.left_child.data == value || parent_node.right_child.data == value
    if value < parent_node.data 
      find_parent_node(value, parent_node.left_child) 
    else
      find_parent_node(value, parent_node.right_child)
    end
  end

  def link_descendant_node(node)
    linking_node = node.right_child
    if linking_node.left_child.nil?
      linking_node.left_child = node.left_child
      linking_node
    else
      linking_node = linking_node.left_child until linking_node.left_child.nil?
      linking_node_parent = find_parent_node(linking_node.data)
      linking_node_parent.left_child = linking_node.right_child
      linking_node.left_child = node.left_child
      linking_node.right_child = node.right_child
      linking_node
    end
  end 

  def link_child_node(node) 
    if node.leaf?
      nil
    elsif node.right_child.nil?
      node.left_child
    elsif node.left_child.nil?
      node.right_child
    else
      link_node = link_descendant_node(node)
    end
  end
end




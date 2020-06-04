class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child
  def initialize(data = nil)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(node)
    # return nil if node == nil
    data <=> node.data
  end

  def leaf?
    self.left_child == nil && self.right_child == nil
  end
end
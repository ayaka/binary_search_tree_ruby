require_relative "./lib/tree.rb"

tree = Tree.new(Array.new(15) { rand(1..100) })

puts tree.balanced?
print_all = Proc.new { |node| puts node.data }
tree.level_order(&print_all)
puts
tree.level_order_r(&print_all)
puts
tree.preorder(&print_all)
puts
tree.postorder(&print_all)
puts
tree.inorder(&print_all)
puts
tree.insert(111)
tree.insert(222)
tree.insert(333)
puts tree.balanced?
tree.rebalance!
puts tree.balanced?
tree.level_order(&print_all)
puts
tree.level_order_r(&print_all)
puts
tree.preorder(&print_all)
puts
tree.postorder(&print_all)
puts
tree.inorder(&print_all)
puts
require_relative 'BST'

bst = Tree.new(Array.new(15) { rand(1..100) })
bst.pretty_print
p bst.balanced?
puts "Level order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Inorder: #{bst.inorder}"
puts "Postorder: #{bst.postorder}"
bst.insert(150)
bst.insert(250)
bst.insert(111)
bst.insert(183)
bst.pretty_print
p bst.balanced?
bst.rebalance
bst.pretty_print
p bst.balanced?
puts "Level order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Inorder: #{bst.inorder}"
puts "Postorder: #{bst.postorder}"
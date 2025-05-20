require_relative "lib/tree"

t = Tree.new(Array.new(15) { rand(1..100) })
puts t.pretty_print

puts "Balanced: #{t.balanced?}"
puts "Level-Order: #{t.level_order}"
puts "Preorder: #{t.preorder}"
puts "Inorder: #{t.inorder}"
puts "Postorder: #{t.postorder}"

gets

t.insert(120)
t.insert(101)
t.insert(199)
t.insert(9999)

puts t.pretty_print
puts "Balanced: #{t.balanced?}"

gets

t.rebalance
puts t.pretty_print
puts "Balanced: #{t.balanced?}"
puts "Level-Order: #{t.level_order}"
puts "Preorder: #{t.preorder}"
puts "Inorder: #{t.inorder}"
puts "Postorder: #{t.postorder}"

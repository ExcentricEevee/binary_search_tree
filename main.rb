require_relative "lib/tree"

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(arr)

puts t.pretty_print

arr = []
t.postorder { |node| arr.push(node.data + 1) }
p arr
p t.postorder

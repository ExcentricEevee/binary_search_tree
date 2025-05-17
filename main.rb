require_relative "lib/tree"

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(arr)

puts t.pretty_print

p t.level_order

updated_values = []
t.level_order do |obj|
  updated_values.push(obj.data + 1)
end

p updated_values

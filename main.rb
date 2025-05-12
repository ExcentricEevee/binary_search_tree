require_relative "lib/node"

n1 = Node.new(1)
n2 = Node.new(2)
n3 = Node.new(10)
n4 = Node.new(-4)

p n1 < n2
p n2.between?(n1, n3)
p n3.between?(n1, n2)
p [n2, n3, n4, n1].sort

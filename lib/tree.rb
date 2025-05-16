require_relative "node"
require_relative "sortable"

# Builds a Balanced Binary Search Tree using Node objects
# Attempts to keep the difference in depth between both sides no greater than 1
# Sorts provided array upon building tree; does not assume to already be sorted
class Tree
  include Sortable

  def initialize(arr)
    # removing dups to avoid headaches
    @root = build_tree(merge_sort(arr).uniq)
  end

  def insert(value, root = self.root)
    return Node.new(value) if root.nil?
    return root if root.data == value

    value > root.data ? root.right = insert(value, root.right) : root.left = insert(value, root.left)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  attr_accessor :root

  def build_tree(arr)
    return if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..])

    root
  end
end

# For my convenience:
# require "pry-byebug";binding.pry

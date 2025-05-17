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

  def delete(value, root = self.root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else
      # zero children or only right child
      return root.right if root.left.nil?
      # only left child
      return root.left if root.right.nil?

      # when both children are present
      succ = get_successor(root)
      root.data = succ.data
      root.right = delete(succ.data, root.right)
    end

    root
  end

  def find(value)
    temp = root
    temp = value < temp.data ? temp.left : temp.right until temp.nil? || temp.data == value
    temp
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

  def get_successor(node)
    node = node.right
    node = node.left until node.left.nil?
    node
  end
end

# For my convenience:
# require "pry-byebug";binding.pry

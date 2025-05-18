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

  def level_order
    queue = [root]
    values = []

    until queue.empty?
      node = queue.shift
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?

      block_given? ? yield(node) : values.push(node.data)
    end

    values unless block_given?
  end

  def preorder(node = root, values = [], &block)
    return if node.nil?

    block_given? ? block.call(node) : values.push(node.data)
    preorder(node.left, values, &block)
    preorder(node.right, values, &block)

    values unless block_given?
  end

  def inorder(node = root, values = [], &block)
    return if node.nil?

    inorder(node.left, values, &block)
    block_given? ? block.call(node) : values.push(node.data)
    inorder(node.right, values, &block)

    values unless block_given?
  end

  def postorder(node = root, values = [], &block)
    return if node.nil?

    postorder(node.left, values, &block)
    postorder(node.right, values, &block)
    block_given? ? block.call(node) : values.push(node.data)

    values unless block_given?
  end

  def height(value)
    node = find(value)
    return if node.nil?

    get_count(node)
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

  def get_count(node)
    # base case; -1 for not counting node you start on
    return -1 if node.nil?

    left_height = get_count(node.left)
    right_height = get_count(node.right)
    [left_height, right_height].max + 1
  end
end

# For my convenience:
# require "pry-byebug";binding.pry

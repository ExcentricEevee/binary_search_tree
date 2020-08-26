require_relative 'array_management'
require 'pry'

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root, :temp, :final

  def initialize(array)
    array = merge_sort(array)
    array = remove_dups(array)
    @root = build_tree(array, 0, (array.length-1))
  end

  #returns an array into a balanced binary tree full of Node objectse
  def build_tree(array, start, finish)
    #base case
    return nil if start > finish

    mid = (start + finish) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, start, mid-1)
    root.right = build_tree(array, mid+1, finish)

    return root
  end

  def insert(root = @root, value)
    if root.data == nil
      root.data == value
    else
      if root.data > value
        if root.left == nil
          root.left = Node.new(value)
        else
          insert(root.left, value)
        end
      else
        if root.right == nil
          root.right = Node.new(value)
        else
          insert(root.right, value)
        end
      end
    end
  end

  #Had help from geeksforgeeks with this instead of solve purely;
  #no shame in help, just remember you might need to review this
  def delete(root = @root,  value)
    return root if root == nil

    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    #if this node has the value we're looking for, then we delete it
    else
      #node with only one or no child
      if root.left == nil
        temp = root.right
        root = nil
        return temp
      elsif root.right == nil
        temp = root.left
        root = nil
        return temp
      end

      #Node with two children: get Inorder successor (smallest in right subtree)
      temp = minValueNode(root.right)
      root.data = temp.data
      root.right = delete(root.right, temp.data)
    end
    return root
  end

  #for use with #delete, may just combine them, but this is good DRY stuff
  def minValueNode(node)
    current = node
    #loop down to leftmost leaf
    until current.left == nil
      current = current.left
    end
    return current
  end

  def find(root = @root, value)
    if root == nil || root.data == value
      return root
    end
#binding.pry
    if value < root.data
      find(root.left, value)
    else
      find(root.right, value)
    end
  end

  #breadth-first search; returns array of values
  #Time-complexity: O(n) ~ Space-complexity: O(1) best / O(n) worst/avg
  def level_order(root = @root)
    queue = []
    result = []

    return root if root == nil
    queue.push(root)

    until queue.length <= 0 do
      current = queue.shift
      result.push(current.data)

      unless current.left == nil
        queue.push(current.left)
      end

      unless current.right == nil
        queue.push(current.right)
      end
    end
    return result
  end

  #left -> root -> right
  def inorder(root = @root, result = [], stack = [])
    return root if root == nil

    #add root to stack, and move down left subtree until you hit a leaf
    stack.push(root)
    inorder(root.left, result, stack)

    #read data
    current = stack.pop
    result.push(current.data)

    #continue with right subtree
    inorder(root.right, result, stack)

    result
  end

  #root -> left -> right
  def preorder(root = @root, result = [])
    return root if root == nil

    result.push(root.data)
    preorder(root.left, result)
    preorder(root.right, result)
    return result
  end

  #left -> right -> root
  def postorder(root = @root, result = [], stack = [])
    return root if root == nil

    #obtain all leaves first, and parents after
    stack.push(root)
    postorder(root.left, result, stack)
    postorder(root.right, result, stack)

    current = stack.pop
    result.push(current.data)

    result
  end

  #number of edges in longest path from given node to leaf node
  #in other words: distance from deepest accessable leaf to given node
  def height(target, current = find(target))
    #we use -1 here because we need to uncount the pass into a nil reference
    return -1 if current == nil

    left_tree = height(target, current.left)
    right_tree = height(target, current.right)

    #IT'S LIKE RECURSIVE FIBONACCI
    return ([left_tree, right_tree].max)+1
  end

  #number of edges from root to given node
  #in other words: distance from root to given node
  def depth(target, current = @root, counter = 0)
    return counter if current.data == target

    begin
      if target < current.data
        counter += 1
        depth(target, current.left, counter)
      else
        counter += 1
        depth(target, current.right, counter)
      end
    rescue
      puts "[Error] This node does not exist in the tree."
    end
  end

  def balanced?
    difference = (height(@root.left.data) - height(@root.right.data)).abs
    difference <= 1 ? true : false
  end

  def rebalance
    level_array = inorder
    @root = build_tree(level_array, 0, (level_array.length)-1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end
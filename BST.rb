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
    @temp = merge_sort(array)
    @final = remove_dups(@temp)
    @root = build_tree(@final, 0, (@final.length-1))
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

  def delete(value)

  end

  def find(root = @root, value)
    if root == nil || root.data == value
      return root
    end

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

  #needs work; I HAVE NO IDEA WHAT I'M DOING
  #I need to understand the problem itself first
  def height(node = @root, counter = 0)
    return counter if node.left == nil && node.right == nil

    counter += 1

    if node.left
      left = height(node.left, counter)
    end

    if node.right
      right = height(node.right, counter)
    end

    if left > right
      left
    else
      right
    end
  end

  def balanced?
    difference = (height(@root.left) - height(@root.right)).abs
    difference <= 1 ? true : false
  end

end

bst = Tree.new([1, 7, 4, 23, 8, 9, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p bst.height
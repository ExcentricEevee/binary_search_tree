require_relative 'merge_sort'

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  #returns an array into a balanced binary tree full of Node objects
  #Start by sortting and removing duplicates; should return the lv1 root node
  def build_tree(unsorted_array)
    #not very efficient since this method is recursive, but oh well
    sorted_arr = merge_sort(unsorted_array)
    arr = remove_dups(sorted_arr)

    if arr.length == 1
      return arr
    end

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0..(mid-1)])
    root.right = build_tree(arr[(mid+1)..arr.length])
    root
  end

  def remove_dups(array)
    array.each_index do |idx|
      if array[idx+1] == nil
        break
      elsif array[idx] == array[idx+1]
        array.delete_at(idx+1)
      end
    end
    array
  end

end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p bst.root
require_relative "node"
require_relative "sortable"

# Builds a Balanced Binary Search Tree using Node objects
# Attempts to keep the difference in depth between both sides no greater than 1
# Sorts provided array upon building tree; does not assume to already be sorted
class Tree
  include Sortable

  def initialize(arr)
    @root = build_tree(arr)
  end

  private

  attr_accessor :root

  def build_tree(arr)
    # intentionally removing dups to avoid headaches
    merge_sort(arr).uniq
  end
end

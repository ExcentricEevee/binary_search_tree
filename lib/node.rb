# Object for storing data as well as left and right side nodes in a tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  private

  def <=>(other)
    data <=> other.data
  end
end

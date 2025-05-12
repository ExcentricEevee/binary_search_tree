# Making binary trees requires that it accepts *sorted* arrays
# Sortable provides merge sort as an option to achieve this
module Sortable
  def merge_sort(array)
    # base case; it's already sorted
    return array if array.length == 1

    # sort left and right halves
    left = merge_sort(array[0..(array.length / 2) - 1])
    right = merge_sort(array[array.length / 2..array.length - 1])

    merge(left, right)
  end

  private

  def merge(left, right)
    merged_array = []

    merged_array.push left[0] > right[0] ? right.shift : left.shift until left.empty? || right.empty?
    left.empty? ? right.each { |n| merged_array.push(n) } : left.each { |n| merged_array.push(n) }

    merged_array
  end
end

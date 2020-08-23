def merge_sort(array)
  if array.length == 1
    return array
  else
    left = merge_sort(array[0..(array.length/2)-1])
    right = merge_sort(array[(array.length/2)..(array.length-1)])

    result = []
    (left.length + right.length).times do
      if left.empty?
        result.push(right.shift)
      elsif right.empty?
        result.push(left.shift)
      else
        if(left[0] < right[0])
          result.push(left.shift)
        else
          result.push(right.shift)
        end
      end
    end

    result
  end
end


def remove_dups(array)
  result = []

  array.each do |value|
    unless result.include?(value)
      result << value
    end
  end
  result
end
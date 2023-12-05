#!/usr/bin/env ruby

input = File.readlines('input.txt')

schem = []

def parse_element(str)
  if str.size == 1
    [str]
  else
    Array.new(str.size, str)
  end
end

def is_num(el)
  if (el.to_i != 0)
    true
  end
end

def remove_num(arr, i, j, num)
  k = l = j
  arr[i][j] = "."

  while k-1 > 0 && arr[i][k-1] == num
    arr[i][k-1] = "."
    k -= 1
  end

  while (l < arr.first.size - 1) && arr[i][l+1] == num
    arr[i][l+1] = "."
    l += 1
  end

  arr
end

def get_adjacents(arr, i, j)
  results = []
  max_i = arr.size - 1
  max_j = arr.first.size - 1

  north = -> (arr, i, j) { i <= 0 ? nil : arr[i-1][j] }
  south = -> (arr, i, j) { i >= max_i ? nil : arr[i+1][j] }
  west = -> (arr, i, j) { j <= 0 ? nil : arr[i][j-1] }
  east = -> (arr, i, j) { j >= max_j ? nil : arr[i][j+1] }

  northwest = -> (arr, i, j) { (west.call(arr, i, j).nil? || north.call(arr, i, j).nil?) ? nil : arr[i-1][j-1] }
  northeast = -> (arr, i, j) { (east.call(arr, i, j).nil? || north.call(arr, i, j).nil?) ? nil : arr[i-1][j+1] }
  southwest = -> (arr, i, j) { (west.call(arr, i, j).nil? || south.call(arr, i, j).nil?) ? nil : arr[i+1][j-1] }
  southeast = -> (arr, i, j) { (east.call(arr, i, j).nil? || south.call(arr, i, j).nil?) ? nil : arr[i+1][j+1] }

  if is_num(east.call(arr, i, j))
    results << east.call(arr, i, j)
    arr = remove_num(arr, i, j+1, east.call(arr, i, j))
  end

  if is_num(southeast.call(arr, i, j))
    results << southeast.call(arr, i, j)
    arr = remove_num(arr, i+1, j+1, southeast.call(arr, i, j))
  end

  if is_num(south.call(arr, i, j))
    results << south.call(arr, i, j)
    arr = remove_num(arr, i+1, j, south.call(arr, i, j))
  end

  if is_num(southwest.call(arr, i, j))
    results << southwest.call(arr, i, j)
    arr = remove_num(arr, i+1, j-1, southwest.call(arr, i, j))
  end

  if is_num(west.call(arr, i, j))
    results << west.call(arr, i, j)
    arr = remove_num(arr, i, j-1, west.call(arr, i, j))
  end

  if is_num(northwest.call(arr, i, j))
    results << northwest.call(arr, i, j)
    arr = remove_num(arr, i-1, j-1, northwest.call(arr, i, j))
  end

  if is_num(north.call(arr, i, j))
    results << north.call(arr, i, j)
    arr = remove_num(arr, i-1, j, north.call(arr, i, j))
  end

  if is_num(northeast.call(arr, i, j))
    results << northeast.call(arr, i, j)
    arr = remove_num(arr, i-1, j+1, northeast.call(arr, i, j))
  end

  if results.size == 2
    return (results.map(&:to_i)[0] * results.map(&:to_i)[1])
  else
    return 0
  end
end

input.each do |row|
  split_row = row.chomp.split(/(?<=[.\D*])/)
  even_more_split_row = split_row.map do |el|
    if el.size > 1 && el[-1].to_i == 0
      [parse_element(el[0..-2]), el[-1]]
    elsif el.size > 1
      [parse_element(el)]
    else
      [el]
    end
  end.flatten

  schem << even_more_split_row
end

tot = 0

schem.size.times do |i|
  schem.first.size.times do |j|
    if !is_num(schem[i][j]) && schem[i][j] != "."
      tot += get_adjacents(schem, i, j)
    end
  end
end

puts tot

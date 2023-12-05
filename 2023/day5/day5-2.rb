#!/usr/bin/env ruby

input = File.readlines('input.txt')
seeds = input.first.split(":").last.split(" ").map(&:to_i).each_slice(2).to_a.sort

blanks = input.each_with_index.select { |line, index| line == "\n" }.map(&:last)

maps = []

blanks.append(input.size - 1).each_cons(2) do |index, next_index|
  chunk = input.slice(index, next_index - index)

  chunk.map! do |line|
    next if line.scan(/\d/).empty?

    line.chomp.split(" ").map(&:to_i)
  end

  maps << chunk.compact
end

def in_to_out(input, mapping)
  splits = []

  # Cut the mapping into sections for each range of input values
  mapping.each do |destination, source, range|
    if input.first > (source + range)
      next
    elsif (input.first + input.last) < source
      next
    end

    start = [input.first, source].max
    finish = [input.first + input.last, source + range - 1].min
    offset = destination - source
    splits << { start: start, finish: finish, offset: offset }
  end

  last_split = input.first
  additional_splits = []

  # Add missing sections where there's a 0 offset
  splits.sort_by { |el| el[:start] }.each do |split|
    if split[:start] > last_split
      additional_splits << { start: last_split, finish: split[:start] - 1, offset: 0 }
    end

    last_split = split[:finish] + 1
  end

  splits += additional_splits

  # Transform back into [start, length] pairs after applying the offset
  splits.map! do |split|
    [split[:start] + split[:offset], split[:finish] - split[:start]]
  end

  return splits
end

def combine_ranges(ranges)
  sorted = ranges.sort_by(&:first)
  combined = []
  working_range = sorted.first

  sorted.each do |rge|
    if rge.first < working_range.last
      working_range = [working_range.first, rge.last]
    else
      combined << [working_range.first, working_range.last]
      working_range = rge
    end
  end

  combined << working_range

  return combined
end

locations = maps.reduce(seeds) do |acc, map|
  combine_ranges(acc).map { |acc| in_to_out(acc, map) }.flatten(1)
end

pp locations.sort_by(&:first).first.first

#!/usr/bin/env ruby

input = File.readlines('input.txt')

lines = input.map { |line| line.split(" ").map(&:to_i).reverse }

def get_diffs(line)
  line.each_cons(2).reduce([]) do |acc, pair|
    acc << pair[1] - pair[0]
  end
end

sum = lines.reduce(0) do |acc, line|
  # Build array of differences—the first line will always have some, even if they're all 0
  line_diffs = [get_diffs(line)]

  while line_diffs.last.uniq != [0]
    line_diffs << get_diffs(line_diffs.last)
  end

  # We don't care about the first value in _every_ line, just the first. We just need to
  # keep track of what the adjustment value is for each row moving back up from the
  # bottom
  adjustment = line_diffs.reverse.reduce(0) do |tmp, line|
    line.last + tmp
  end

  # Yeehaw
  acc += line.last + adjustment
end

puts sum

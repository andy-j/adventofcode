#!/usr/bin/env ruby

input = File.readlines('input.txt')

directions = input.first.chomp.split("")

network = {}
starts = []
ends = []

input.each do |line|
  node, left, right = line.scan(/\w{3}/)
  network[node] = [left, right]
  starts << node if node&.chars&.last == "A"
end

starts.each do |current|
  counter = 0

  while current.chars.last != "Z" do
    current = directions[counter % directions.size] == "L" ? network[current].first : network[current].last
    counter += 1
  end
  ends << counter
end

puts ends.reduce(:lcm)

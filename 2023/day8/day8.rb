#!/usr/bin/env ruby

input = File.readlines('input.txt')

directions = input.first.chomp.split("")

network = {}

input.each do |line|
  next if line.scan(/\=/).empty?
  node, left, right = line.scan(/\w{3}/)
  network[node] = [left, right]
end

counter = 0
current = "AAA"

while current != "ZZZ" do
  puts "\"#{current}\": #{network[current]}"
  current = directions[counter % directions.size] == "L" ? network[current].first : network[current].last
  counter += 1
end

puts counter

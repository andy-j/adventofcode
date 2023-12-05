#!/usr/bin/env ruby

input = File.readlines('input.txt')
seeds = input.first.split(":").last.split(" ").map(&:to_i)

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

def get_destination(input, mapping)
  output = nil

  mapping.each do |destination, source, range|
    next if input < source || input > (source + range)
    output = (input - source) + destination
    break
  end

  output || input
end

location = seeds.map do |seed|
  maps.reduce(seed) do |acc, map|
    get_destination(acc, map)
  end
end

pp location.min

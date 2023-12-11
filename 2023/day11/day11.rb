#!/usr/bin/env ruby

require "pry"

input = File.readlines('input.txt')

first_there_was_nothing = []
@universe = []

input.each do |line|
  first_there_was_nothing << line.chomp.split("")
  first_there_was_nothing << line.chomp.split("") if first_there_was_nothing.last.all?(".")
end

first_there_was_nothing.transpose.each do |column|
  @universe << column
  @universe << column if @universe.last.all?(".")
end

@universe

galaxies = []

@universe.each_with_index do |line, y|
  line.each_with_index do |tile, x|
    galaxies << [x, y] if tile == "#"
  end
end

# Get every pair of galaxies, zip 'em together, and find the difference
# between their x corresponding x and y coordinates. Then, we add the
# differences to find the manhattan distance between the pair, and then
# add all of the distances up!
pp galaxies.combination(2).to_a.map { |first, second| first.zip(second).map { |pair| pair.reduce(:-) }.map(&:abs).reduce(:+) }.sum

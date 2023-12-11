#!/usr/bin/env ruby

require "pry"

input = File.readlines('input.txt')

EMBIGGENING_FACTOR = 1_000_000

@universe = []

input.each do |line|
  @universe << line.chomp.split("")
end

big_rows = []
big_columns = []

@universe.each_with_index { |row, index| big_columns << index if row.all?(".") }
@universe.transpose.each_with_index { |col, index| big_rows << index if col.all?(".") }

galaxies = []

@universe.each_with_index do |line, y|
  line.each_with_index do |tile, x|
    if tile == "#"
      gal = [x, y]

      x_adjustment = big_rows.count { |row| row < gal[0] } * (EMBIGGENING_FACTOR - 1)
      y_adjustment = big_columns.count { |col| col < gal[1] } * (EMBIGGENING_FACTOR - 1)

      gal[0] = gal[0] + x_adjustment if x_adjustment > 0
      gal[1] = gal[1] + y_adjustment if y_adjustment > 0

      galaxies << gal
    end
  end
end

# Get every pair of galaxies, zip 'em together, and find the difference
# between their x corresponding x and y coordinates. Then, we add the
# differences to find the manhattan distance between the pair, and then
# add all of the distances up!
pp galaxies.combination(2).to_a.map { |first, second| first.zip(second).map { |pair| pair.reduce(:-) }.map(&:abs).reduce(:+) }.sum

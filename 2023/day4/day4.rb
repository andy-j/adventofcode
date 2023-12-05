#!/usr/bin/env ruby

input = File.readlines('input.txt')

sum = 0

input.each do |card|
  first, second = card.chomp.split(":").last.split("|")
  winners = first.split(" ").map(&:to_i)
  mine = second.split(" ").map(&:to_i)

  matches = (winners & mine).size

  if matches > 0
    sum += 2**((winners & mine).size - 1)
  end
end

puts sum

#!/usr/bin/env ruby

input = File.readlines('input.txt')

powers = []

input.each do |game|
  id, rounds = game.split(":")

  rounds = rounds.split(";")

  reds = rounds.map { |round| round[/(\d*) red/, 1].to_i }.max
  greens = rounds.map { |round| round[/(\d*) green/, 1].to_i }.max
  blues = rounds.map { |round| round[/(\d*) blue/, 1].to_i }.max

  powers << reds * greens * blues
end

puts powers.sum

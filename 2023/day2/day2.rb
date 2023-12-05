#!/usr/bin/env ruby

input = File.readlines('input.txt')

valid_games = []

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

input.each do |game|
  id, rounds = game.split(":")

  rounds = rounds.split(";")

  reds_ok = rounds.select { |round| round[/(\d*) red/, 1].to_i > MAX_RED }.none?
  greens_ok = rounds.select { |round| round[/(\d*) green/, 1].to_i > MAX_GREEN }.none?
  blues_ok = rounds.select { |round| round[/(\d*) blue/, 1].to_i > MAX_BLUE }.none?

  next unless reds_ok && greens_ok && blues_ok

  puts id[/Game (\d*)/, 1]
  valid_games << id[/Game (\d*)/, 1].to_i
end

puts valid_games.sum

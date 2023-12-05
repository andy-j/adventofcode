#!/usr/bin/env ruby

input = File.readlines('input.txt')

cards = {}

input.each do |card|
  # String parsing BS: pull the card number, the winning numbers, and the numbers
  # on the card into vars
  num = card.scan(/(\d*):/).flatten.first.to_i
  winners, mine = card.chomp.split(":").last.split("|").map { |chunk| chunk.split(" ").map(&:to_i) }

  # We start with one of these each, but we end with more!
  cards[num] = { quantity: 1, winners: (winners & mine).size }
end

# Cards can't win previous cards, so we can just go in order here from 1 -> end
# I tried just appending to an array but it got out of hand quickly; tracking
# the quantity of each card we have on hand so we can bulk process all of them
# at once is much nicer.
(1..cards.size).each do |card|
  winners = cards[card][:winners]

  # There has to be a cleaner way to do this; I hate range syntax (especially
  # if I'm adding or subtracting to the bounds) but here we are!
  ((card+1)..(card+winners)).to_a.each do |won_card|
    # Add one of the cards we one for every copy of the current card we have
    cards[card][:quantity].times do
      cards[won_card][:quantity] += 1
    end
  end
end

# Yeehaw
puts cards.values.reduce(0) { |acc, card| acc + card[:quantity]}

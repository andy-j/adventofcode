#!/usr/bin/env ruby

input = File.readlines('input.txt')

CARDS = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

def rank(hand)
  case hand.chars.tally.values.sort
  when [5]
    return 6
  when [1,4]
    return 5
  when [2,3]
    return 4
  when [1,1,3]
    return 3
  when [1,2,2]
    return 2
  when [1,1,1,2]
    return 1
  else
    return 0
  end
end

def compare_hands(hand1, hand2)
  return -1 if rank(hand1) > rank(hand2)
  return 1 if rank(hand1) < rank(hand2)

  return -1 if stringify_hand(hand1) > stringify_hand(hand2)
  return 1 if stringify_hand(hand1) < stringify_hand(hand2)

  return 0
end

def stringify_hand(hand)
  hand.chars.map { |char| ('a'..'z').to_a.reverse[CARDS.index(char)] }.join
end

hands = input.map do |line|
  line.chomp.split(" ")
end

hands.sort! { |a,b| compare_hands(a.first, b.first) }

winnings = 0

hands.each_with_index do |hand, index|
  winnings += ((1000 - index) * hand.last.to_i)
end

puts winnings

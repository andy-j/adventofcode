#!/usr/bin/env ruby

numbers = ["-", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
srebmun = numbers.map(&:reverse)

def get_number(numbers, srebmun, input)
  first = numbers.map do |num|
    [input.index(num), num]
  end.reject { |arr| arr.first.nil? }.sort.first.last
  last = srebmun.map do |mun|
    [input.reverse.index(mun), mun]
  end.reject { |arr| arr.first.nil? }.sort.first.last

  first = last if first.nil?
  last = first if last.nil?

  10*(numbers.index(first) % 10) + (srebmun.index(last) % 10)
end

puts File.readlines('input.txt').map { |input| get_number(numbers, srebmun, input) }.sum

#!/usr/bin/env ruby

require "pry"

@print_path = true

input = File.readlines('input.txt')

DIRECTIONS = {
  "n" => [-1,0],
  "s" => [1,0],
  "e" => [0,1],
  "w" => [0,-1]
}

PIPE_ENDS = {
  '|' => ['n','s'],
  '-' => ['e','w'],
  'L' => ['n','e'],
  'J' => ['n','w'],
  '7' => ['s','w'],
  'F' => ['s','e'],
  '.' => [],
  'S' => ['s','w']
}

ASCII_TYPES = {
  '|' => '┃',
  '-' => '━',
  'L' => '┗',
  'J' => '┛',
  '7' => '┓',
  'F' => '┏',
  '.' => '▪',
  'S' => '┏' # hardcoded for starting spot
}

@start = nil
@grid = {}
@visited = {}
@dimensions = [input.size, input.first.size]

input.map.with_index do |line, x|
  @start = [x, line.index("S")] if line.index("S")
  line.chomp.split("").each_with_index do |char, y|
    @grid["#{x},#{y}"] = char
  end
end

def grid_at(coords)
  @grid["#{coords.first},#{coords.last}"]
end

def visited?(coords)
  @visited["#{coords.first},#{coords.last}"]
end

def adjacents(coords)
  return if coords.nil? || coords == []

  links = PIPE_ENDS[grid_at(coords)]
    .map { |dir| DIRECTIONS[dir] }
    .map { |link| link.zip(coords).map { |pair| pair.reduce(:+) } }
    .select { |link| link[0].between?(0, @dimensions[0]) && link[1].between?(0, @dimensions[1]) }
    .reject { |link| visited?(link) }
end

def find_path(beginning)
  path = []
  current = beginning

  while adjacents(current)
    path << current
    @visited["#{current.first},#{current.last}"] = true
    current = adjacents(current).first
  end

  return path
end

path = find_path(@start)

if @print_path
  path.each do |pt|
    x, y = pt
    @grid["#{x},#{y}"] = ASCII_TYPES[grid_at(pt)]
  end

  @dimensions.first.times do |x|
    @dimensions.last.times do |y|
      print @grid["#{x},#{y}"]
    end
    puts
  end
end

puts "#{path.size / 2} steps from the farthest point."

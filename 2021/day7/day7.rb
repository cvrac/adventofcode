# frozen_string_literal: true

def solve(input, range)
  range.map { |x| input.reduce(0) { |cost, y| cost + (yield (x - y).abs) } }.min
end

input = File.read('input.txt').split(',').map(&:to_i).sort!
range = (input.min)..(input.max)

puts solve(input, range) { |diff| diff }
puts solve(input, range) { |diff| ((diff + 1) * diff / 2).round }

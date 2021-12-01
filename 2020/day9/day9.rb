require 'set'
data = File.read('input.txt').split("\n").map(&:to_i)

number = data.each_cons(26).find { |window| window[0..-1].combination(2).none? { |pair| pair.sum == window.last } }.last

p number

def contiguous_set(data, left, right, number)
  return false if right == data.size

  $set << data[right]

  return true if data[left..right].sum == number


  contiguous_set(data, left, right + 1, number)
end

number = data.each_with_index.find.map do |n, left|
  $set = Set.new
  $set << n
  $set.min + $set.max if contiguous_set(data, left, left + 1, number)
end.compact.first

p number

depths = File.readlines('inputs/day1.txt').map(&:to_i)

puts depths.each_cons(2).inject(0) { |inc, pair| pair.last > pair.first ? inc + 1 : inc }

puts depths.each_cons(4).inject(0) { |inc, window|
  measurements = window.each_cons(3).map(&:sum)
  measurements[1] > measurements[0] ? inc + 1 : inc
}

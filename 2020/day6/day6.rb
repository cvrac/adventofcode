groups = File.read('input.txt').split("\n\n")

puts groups.sum { |group| group.split("\n").map(&:chars).reduce(:|).count }

puts groups.sum { |group| group.split("\n").map(&:chars).reduce(:&).count }

grid = File.read('input.txt').split("\n")

length = grid.first.size

def trees(grid, y, x, length)
  grid.each_with_index.reduce(0) do |trees, (l, i)|
    next(trees) if i % y != 0 || !i

    l[(i * x / y) % length] == '#' ? trees + 1 : trees
  end
end

puts '----part1----'

puts trees(grid, 1, 3, length)

puts '----part2----'

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

puts slopes.reduce(1) { |prod, (r, d)| prod * trees(grid, d, r, length) }

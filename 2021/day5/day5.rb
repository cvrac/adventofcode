def horizontal?(point1, point2)
  point1[0] == point2[0] && point1[1] != point2[1]
end

def vertical?(point1, point2)
  point1[1] == point2[1] && point1[0] != point2[0]
end

def points_between(point1, point2)
  if horizontal?(point1, point2)
    start = [point1[1], point2[1]].min
    finish = [point1[1], point2[1]].max

    (start..finish).map { |j| [point1[0], j] }
  elsif vertical?(point1, point2)
    start = [point1[0], point2[0]].min
    finish = [point1[0], point2[0]].max

    (start..finish).map { |i| [i, point1[1]] }
  elsif point1[0] < point2[0] && point1[1] < point2[1]
    (point1[0]..point2[0]).to_a.zip(point1[1]..point2[1]).to_a
  elsif point1[0] < point2[0] && point1[1] > point2[1]
    (point1[0]..point2[0]).to_a.zip(point1[1].downto(point2[1]).to_a)
  elsif point1[0] > point2[0] && point1[1] < point2[1]
    point1[0].downto(point2[0]).zip((point1[1]..point2[1]).to_a)
  elsif point1[0] > point2[0] && point1[1] > point2[1]
    point1[0].downto(point2[0]).zip(point1[1].downto(point2[1]).to_a)
  end
end

def overlaps(lines)
  lines.each_with_object(Hash.new(0)) do |(p1, p2), result|
    points_between(p1, p2).each { |x, y| result[[x, y]] += 1 }
  end
end

def part1(lines)
  overlaps(lines.select { |line| horizontal?(*line) || vertical?(*line) })
    .values
    .count { |v| v >= 2 }
end

def part2(lines)
  overlaps(lines).values.count { |v| v >= 2 }
end

def read_input(input)
  input.split("\n").map do |line|
    line.strip.split(' -> ').map { |range| range.split(',').map(&:to_i) }
  end
end

input = read_input(File.read('input.txt'))
puts part1(input)
puts part2(input)

input = File.readlines('input.txt')

# input = '2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678'


low_points = []

input.each_with_index do |line, i|
  line.each_char.with_index do |c, j|
    up = (i - 1 >= 0) ? input[i - 1][j] > c : nil
    down = (i + 1 < input.size) ? input[i + 1][j] > c : nil
    left = (j - 1 >= 0) ? line[j - 1] > c : nil
    right = (j + 1 < line.size) ? line[j + 1] > c : nil

    neighbors = [up, down, left, right]
    puts "#{c} => #{[up, down, left, right]}, #{line[j+1]}"
    low_points << c if neighbors.compact.all?(true)
  end
  puts "#{i}:#{line} => #{low_points}"
end

print low_points.map(&:to_i).sum + low_points.count

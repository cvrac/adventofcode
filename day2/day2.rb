lines = File.read('input.txt').split("\n")

passwords_matching = lines.count do |line|
  /(?<min>\d*)-(?<max>\d*) (?<letter>\w): (?<password>.*)/ =~ line

  password.count(letter).between?(min.to_i, max.to_i)
end

puts '----part1----'
puts passwords_matching

puts '----part2----'

passwords_matching_2 = lines.count do |line|
  /(?<min>\d*)-(?<max>\d*) (?<letter>\w): (?<password>.*)/ =~ line

  (password[min.to_i - 1] == letter && password[max.to_i - 1] != letter) ||
    (password[min.to_i - 1] != letter && password[max.to_i - 1] == letter)
end

puts passwords_matching_2

calories = File.readlines('input.txt')

total_per_elf = 0

sorted_calories = calories.each_with_object([]) do |calorie, elf_calories|
  next(total_per_elf += calorie.to_i) unless calorie == "\n"

  elf_calories << total_per_elf
  total_per_elf = 0
end

(sorted_calories << total_per_elf).sort!

puts sorted_calories.last

puts sorted_calories.last(3).sum

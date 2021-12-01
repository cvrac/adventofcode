input = File.open('input.txt')

lines = input.read.split

checked_nums = { 0 => true }

lines.each do |li|
  num = li.to_i
  check_num = 2020 - num

  if checked_nums[check_num]
    puts "#{check_num} + #{num} = 2020"
    puts "#{check_num} * #{num} = #{check_num * num}"

    break
  end

  checked_nums[num] = true
end

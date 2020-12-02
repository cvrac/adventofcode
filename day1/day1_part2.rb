input = File.open('input.txt')

lines = input.read.split

checked_nums = { 0 => true }

lines.each_with_index do |li, i|
  num = li.to_i
  found_outer = false

  lines.drop(i).each_with_index do |li2, i2|
    num_2 = li2.to_i
    found = false

    lines.drop(i2).each do |nn|
      nn = nn.to_i
      if num + num_2 + nn == 2020
        puts "#{nn} + #{num} + #{num_2}= 2020"
        puts "#{nn} * #{num} * #{num_2}= #{nn * num * num_2}"
        found = true

        break
      end
    end

    if found == true
      found_outer = true

      break
    end
  end

  break if found_outer == true
end

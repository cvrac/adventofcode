def count_1(cl, s = 'shiny gold')
  $memo_1[cl] ||= $rules[cl].any? { |c, _| c == s || count_1(c) != 0 } ? 1 : 0
end

def count_2(cl)
  $memo_2[cl] ||= $rules[cl].sum { |c, cn| cn + cn * count_2(c) }
end

color_rg = ->(l) { /(\w+ \w+) bags/.match(l)[1] }
bags_rg = ->(l) { l.scan(/(\d) (\w+ \w+)/).map { |m| [m[1], m[0].to_i] }.to_h }

$rules = File.read('input.txt').split("\n").
  each_with_object({}) { |l, rule| rule[color_rg.call(l)] = bags_rg.call(l) }

$memo_1, $memo_2 = {}, {}

puts $rules.sum { |color, bag| count_1(color) }
puts count_2('shiny gold')

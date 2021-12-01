data = File.read('input.txt').split("\n").
  each_with_index.
  each_with_object({}) { |(l, i), h| h[i] = l }

def execute(data, id, acc)
  return acc if $visited[id] == 1

  $visited[id] = $visited[id] ? $visited[id] + 1 : 1

  /(?<insn>\w+) (?<sign>(\+|\-))(?<off>\d+)/ =~ data[id]

  off = sign == '+' ? off.to_i : -(off.to_i)

  execute(data, id + (insn == 'nop' || insn == 'acc' ? 1 : off), acc + (insn == 'acc' ? off : 0))
end

$visited = {}

puts execute(data, 0, 0)

data.each_with_index do |v, i|
  if data[i].match?('nop')
    data[i] = data[i].gsub('nop', 'jmp')
  elsif data[i].match?('jmp')
    data[i] = data[i].gsub!('jmp', 'nop')
  else
    next
  end

  $visited = {}
  acc = execute(data, 0, 0)
  if $visited[data.keys.last]
    puts acc

    break
  end

  if data[i].match?('nop')
    data[i] = data[i].gsub!('nop', 'jmp')
  elsif data[i].match?('jmp')
    data[i] = data[i].gsub!('jmp', 'nop')
  end
end

def final_position(moves)
  moves.each_with_object(Hash.new(0)) do |(move, i), res|
    res['x'] += move == 'forward' ? i.to_i : 0
    res['y'] += move == 'down' ? i.to_i : 0
    res['y'] -= move == 'up' ? i.to_i : 0

    res
  end
end

def final_position_by_aim(moves)
  moves.each_with_object(Hash.new(0)) do |(move, i), res|
    res['aim'] += move == 'down' ? i.to_i : 0
    res['aim'] -= move == 'up' ? i.to_i : 0
    res['x'] += move == 'forward' ? i.to_i : 0
    res['y'] += move == 'forward' ? i.to_i * res['aim'] : 0

    res
  end
end

moves = File.readlines('input.txt').map { |move| move.split(' ') }

final = final_position(moves)
final_by_aim = final_position_by_aim(moves)

puts final['x'] * final['y']
puts final_by_aim['x'] * final_by_aim['y']

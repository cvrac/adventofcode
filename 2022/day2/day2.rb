round = File.readlines('input.txt').map(&:strip)

score_per_move = { 'X' => 1, 'Y' => 2, 'Z' => 3 }
wins = { 'X' => 'C', 'Y' => 'A', 'Z' => 'B' }
draws = { 'X' => 'A', 'Y' => 'B', 'Z' => 'C' }
loss = { 'X' => 'B', 'Y' => 'C', 'Z' => 'A' }

invert_wins = wins.invert
invert_draws = draws.invert
invert_loss = loss.invert

move_key = { 'X' => invert_loss, 'Y' => invert_draws, 'Z' => invert_wins }

score_a = round.sum do |line|
  move_a, move_b = line.split(' ')

  round_score = score_per_move[move_b]
  round_score += 6 if wins[move_b] == move_a
  round_score += 3 if draws[move_b] == move_a

  round_score
end

puts score_a

score_b = round.sum do |line|
  move_a, outcome = line.split(' ')

  score = 0
  score += 3 if outcome == 'Y'
  score += 6 if outcome == 'Z'

  move = move_key.dig(outcome, move_a)

  score + score_per_move[move]
end

puts score_b

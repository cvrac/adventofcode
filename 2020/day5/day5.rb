boarding_passes = File.read('input.txt').split("\n")

def find_seat(boarding_pass)
  inc = ->(x, y) { x == 'B' || x == 'R' ? (y * 2) + 1 : y * 2 }

  boarding_pass.chars.reduce(0) { |seat, c| inc.call(c, seat) }
end

seat_ids = boarding_passes.map { |pass| find_seat(pass) }

max_seat_id = seat_ids.max
puts max_seat_id

min_seat_id = seat_ids.min

puts (min_seat_id..max_seat_id).reject { |seat| seat_ids.include?(seat) }

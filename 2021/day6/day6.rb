# frozen_string_literal: true

def input_timers_grouped
  @input_timers_grouped ||=
    File
    .read('input.txt')
    .split(',')
    .map(&:to_i)
    .group_by { |v| v }.transform_values(&:count)
end

def solve(timers, days = 80)
  next_day = (0..8).map { |i| [i, timers.key?(i) ? timers[i] : 0] }.to_h

  days.times do
    reborn = next_day[0]
    (0..7).each { |i| next_day[i] = next_day[i + 1] }
    next_day[6] += reborn
    next_day[8] = reborn
  end

  next_day
end

puts solve(input_timers_grouped).values.sum
puts solve(input_timers_grouped, 256).values.sum

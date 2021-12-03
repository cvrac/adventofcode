# frozen_string_literal: true

def most_common_ones(sequences)
  sequences.each_with_object(Hash.new(0)) do |sequence, ones|
    sequence.each_char.with_index do |s, i|
      ones[i] += s == '1' ? 1 : 0
    end
  end
end

def gamma(sequences)
  most_common_ones(sequences).each_with_object(Hash.new(0)) do |(k, v), bits|
    bits[k] = v > sequences.size - 1 - v ? '1' : '0'
  end
end

def epsilon(sequences)
  most_common_ones(sequences).each_with_object(Hash.new(0)) do |(k, v), bits|
    bits[k] = v > sequences.size - 1 - v ? '0' : '1'
  end
end

def power_consumption(sequences)
  gamma(sequences).values.join.to_i(2) * epsilon(sequences).values.join.to_i(2)
end

def find_rating_by(sequences, index, &find_freq)
  return sequences.first.to_i(2) if sequences.size == 1

  frequent_bit = find_freq.call(sequences)[index]
  matching_sequences = sequences.select { |seq| seq[index] == frequent_bit }

  find_rating_by(matching_sequences, index + 1, &find_freq)
end

def life_support_rating(sequences)
  oxygen = find_rating_by(sequences, 0) { |seq| gamma(seq) }
  co = find_rating_by(sequences, 0) { |seq| epsilon(seq) }

  oxygen * co
end

sequences = File.readlines('input.txt').map(&:strip)
# sequences = ['00100', '11110', '10110', '10111', '10101', '01111', '00111', '11100', '10000', '11001', '00010', '01010']

puts power_consumption(sequences)
puts life_support_rating(sequences)

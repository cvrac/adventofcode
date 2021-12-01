require 'pry'
passports = File.read('input.txt').split("\n\n")

required_keys = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid', 'cid']
valid_eye_values = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

def valid_passport_1?(passport, required_keys)
  keys  = passport.split(' ').map { |k| k.split(':').first }

  [['cid'], []].include?(required_keys - keys)
end

valid = passports.reduce(0) do |sum, passport|
  valid_passport_1?(passport, required_keys) ? sum + 1 : sum
end

puts valid

def years_matching?(passport)
  return false unless passport['byr'].to_i.between?(1920, 2002)
  return false unless passport['iyr'].to_i.between?(2010, 2020)
  return false unless passport['eyr'].to_i.between?(2020, 2030)

  true
end

def valid_passport?(passport, valid_eye_values)
  return false unless years_matching?(passport)
  return false unless passport['pid'].match?(/^\d{9}$/)
  return false unless passport['hcl'].match?(/^#[\da-f]+{6}$/)
  return false unless valid_eye_values.include?(passport['ecl'])

  /(?<number>\d+)(?<metric>\w+)/ =~ passport['hgt']

  (metric == 'cm' && number.to_i.between?(150, 193)) ||
    (metric == 'in' && number.to_i.between?(59, 76))
end

valid = passports.reduce(0) do |sum, passport|
  next(sum) unless valid_passport_1?(passport, required_keys)

  passport_hsh = passport.split(' ').map { |k| k.split(':') }.to_h
  valid_passport?(passport_hsh, valid_eye_values) ? sum + 1 : sum
end

puts valid

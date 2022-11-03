input_file = File.read('./4.input').split("\n\n").map(&:split)

mandatory = %i[byr iyr eyr hgt hcl ecl pid]

pp input_file.count { |passport| (mandatory - passport.map { |p| p.split(':').first.to_sym} ).empty? }

def byr_valid?(value)
  value.length == 4 && value.to_i.between?(1920, 2002)
end

def iyr_valid?(value)
  value.length == 4 && value.to_i.between?(2010, 2020)
end

def eyr_valid?(value)
  value.length == 4 && value.to_i.between?(2020, 2030)
end

def hgt_valid?(value)
  return value[0..-3].to_i.between?(150, 193) if value[-2..] == 'cm'

  return value[0..-3].to_i.between?(59, 76) if value[-2..] == 'in'

  false
end

def hcl_valid?(value)
  value.match?(/^#([0-9a-f]{6})$/i)
end

def ecl_valid?(value)
  %w(amb blu brn gry grn hzl oth).include? value
end

def pid_valid?(value)
  value.length == 9
end

def cid_valid?(_value)
  false
end

valid = 0
input_file.each do |passport|
  passport = passport.map { |p| p.split(':') }
  valid += 1 if passport.count { |pass| send(pass.first + '_valid?', pass.last) } == mandatory.length
end

pp valid

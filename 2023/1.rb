input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

sum = 0
input.each do |i|
  i = i.chars.select { _1.to_i.to_s == _1 }.join('')
  sum += "#{i[0]}#{i[-1]}".to_i
end

p sum


digits = {
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
}
sum = 0

input.each do |i|
  digits.each do |k, v|
    i = i.gsub(k.to_s, "#{k}#{v}#{k}")
  end
  i = i.chars.select { _1.to_i.to_s == _1 }.join('')
  sum += "#{i[0]}#{i[-1]}".to_i
end

p sum

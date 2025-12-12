input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

split_input = input.map { _1.split(' ') }
sum = 0
(0...split_input[0].size).each do |i|
  result = 0
  if split_input.last[i] == '+'
    (0...split_input.size).each do |j|
      result += split_input[j][i].to_i
    end
  else
    result = 1
    (0...split_input.size-1).each do |j|
      result *= split_input[j][i].to_i
    end
  end
  sum += result
end
p sum

ops = []
input.last.chars.each_with_index do |c, i|
  if c != ' '
    ops << [c, i, i]
  else
    ops[-1][2] = i
  end
end
ops[-1][2] = input[...-1].max { _1.size }.size

sum = 0
ops.each do |op, from, to|
  result = op == '+' ? 0 : 1
  (from...to).each do |j|
    number = ''
    (0...input.size-1).each do |i|
      number += input[i][j] if input[i][j]
    end
    if op == '+'
      result += number.to_i
    else
      result *= number.to_i
    end
  end
  sum += result
end
p sum

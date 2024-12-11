input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:chars)

def xmas(input, i, j)
  res = []
  res << input[i][j..j+3].join if j < input[0].size - 3
  res << [input[i][j], input[i+1][j], input[i+2][j], input[i+3][j]].join if i < input.size - 3
  res << [input[i-3][j+3], input[i-2][j+2], input[i-1][j+1], input[i][j]].join if i >= 3 && j < input[0].size - 3
  res << [input[i+3][j+3], input[i+2][j+2], input[i+1][j+1], input[i][j]].join if i < input.size - 3 && j < input[0].size - 3

  res
end

count = 0
(0...input.size).each do |i|
  (0...input[0].size).each do |j|
    count += xmas(input, i, j).count('XMAS')
    count += xmas(input, i, j).count('SAMX')
  end
end

p count

def xmas2(input, i, j)
  ['MAS', 'SAM'].include?([input[i][j], input[i+1][j+1], input[i+2][j+2]].join) &&
  ['MAS', 'SAM'].include?([input[i][j+2], input[i+1][j+1], input[i+2][j]].join)
end

count = 0
(0...input.size-2).each do |i|
  (0...input[0].size-2).each do |j|
    count += 1 if xmas2(input, i, j)
  end
end

p count

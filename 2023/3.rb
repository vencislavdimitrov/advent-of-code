input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

def neighbors(data, x, y, num, gears)
  n = [
    [x, y - 1],
    [x - 1, y - 1],
    [x + 1, y - 1],
    [x, y + num.length],
    [x - 1, y + num.length],
    [x + 1, y + num.length]
  ]
  num.length.times do |i|
    n << [x + 1, y + i]
    n << [x - 1, y + i]
  end
  n = n.select { _1[0] < data.length && _1[0] >= 0 && _1[1] < data[0].length && _1[1] >= 0 }
  n.each do |i, j|
    if data[i][j] == '*'
      gears[[i, j]] ||= []
      gears[[i, j]] << num.to_i
    end
  end
  n.any? { ['+', '-', '*', '/', '$', '&', '@', '#', '=', '%'].include? data[_1[0]][_1[1]] }
end

sum = 0
gears = {}
input.each_with_index do |line, line_number|
  ind = line.enum_for(:scan, /\d+/).map { Regexp.last_match.begin(0) }
  ind.each do |i|
    number = line[i..].match(/\d+/)[0]
    sum += number.to_i if neighbors(input, line_number, i, number, gears)
  end
end
p sum

gears_sum = 0
gears.each_value do |v|
  gears_sum += v[0] * v[1] if v.size == 2
end
p gears_sum

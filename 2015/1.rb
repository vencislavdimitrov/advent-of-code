input = File.read(File.basename(__FILE__).gsub('rb', 'input'))

p input.count('(') - input.count(')')

floor = 0
input.chars.each_with_index do |c, i|
  floor += 1 if c == '('
  floor -= 1 if c == ')'

  if floor == -1
    p i + 1
    break
  end
end

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

while input.index('!')
  input[input.index('!'), 2] = ''
end

garbage = 0
while input.index('<')
  garbage += input.index('>') - input.index('<') - 1
  input = input[...input.index('<')] + input[input.index('>') + 1..]
end

input.delete!('^{}')

score = 0
total_score = 0
input.chars.each do |c|
  if c == '{'
    score += 1
  else
    total_score += score
    score -= 1
  end
end

p total_score
p garbage

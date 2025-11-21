input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:to_i)

i = 0
steps = 0
while i < input.size
  old_i = i
  i += input[i]
  input[old_i] += 1
  steps += 1
end
p steps

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:to_i)

i = 0
steps = 0
while i < input.size
  old_i = i
  i += input[i]
  if input[old_i] >= 3
    input[old_i] -= 1
  else
    input[old_i] += 1
  end
  steps += 1
end
p steps

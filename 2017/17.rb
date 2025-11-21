input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.to_i

buffer = [0]
current = 0
(1..2017).each do |i|
  current += input % buffer.size
  current %= buffer.size
  current += 1
  buffer = buffer[0...current] + [i] + buffer[current..]
end
p buffer[current + 1]

buffer = 1
current = 0
element = 0
element_index = 1
(1..50_000_000).each do |i|
  current += input % buffer
  current %= buffer
  current += 1
  if current == element_index
    element = i
  end
  if current < element_index
    element_index += 1
  end
  buffer += 1
end
p element

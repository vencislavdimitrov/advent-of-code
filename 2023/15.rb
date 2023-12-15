input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split(',')

def hash(str)
  hash = 0
  str.each_byte do |b|
    hash = ((hash + b) * 17) % 256
  end
  hash
end

p input.sum { hash(_1) }

boxes = [] * 256
input.each do |lens|
  lens = lens.split(/=|-/)
  hash = hash(lens[0])
  boxes[hash] = [0] * 9 unless boxes[hash]
  if lens.size == 2
    ind = boxes[hash].index { _1[0] == lens[0] } || boxes[hash].index(0)
    boxes[hash][ind] = lens if ind
  else
    boxes[hash].reject! { _1 == 0 || _1[0] == lens[0] }
    boxes[hash] += [0] * (9 - boxes[hash].size)
  end
end

sum = boxes.map.with_index do |box, i|
  if box.nil?
    0
  else
    (i + 1) * box.reject { _1 == 0 }.map.with_index { (_2 + 1) * _1[1].to_i }.sum
  end
end.sum
p sum

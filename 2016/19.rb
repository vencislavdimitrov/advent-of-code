input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.to_i

elfs = [1] * input
elfs = elfs.map.with_index { [_2 + 1, _1] }.to_h

while elfs.filter { _2 > 0}.size > 1
  playing = elfs.filter { _2 > 0 }.keys.sort
  playing.each_slice(2) do |a, b|
    if b.nil?
      elfs[a] += elfs[playing[0]]
      elfs[playing[0]] = 0
    else
      elfs[a] += elfs[b]
      elfs[b] = 0
    end
  end
end
p elfs.select { _2 > 0 }.first.first


queue1 = (1..input/2).to_a
queue2 = (input/2 + 1..input).to_a

while queue1.size + queue2.size > 1
  x = queue1.shift
  if queue1.size == queue2.size
    queue1.pop
  else
    queue2.shift
  end

  queue2 << x
  queue1 << queue2.shift
end
p queue1.first

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.chars.map(&:to_i)

def checksum(input, i)
  until input.size > i
    input = input + [0] + input.reverse.map { _1 == 1 ? 0 : 1 }
  end

  input = input.first(i)

  while input.size.even?
    input = input.each_slice(2).map { _1 == _2 ? 1 : 0 }
  end
  input.join
end

puts checksum(input, 272)
puts checksum(input, 35651584)

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.chars.map(&:to_i)

p (input + [input.first]).each_cons(2).map { _1 == _2 ? _1 : 0 }.sum

p input.each_with_index.map { _1 == input[(_2 + input.size/2) % input.size] ? _1 : 0 }.sum

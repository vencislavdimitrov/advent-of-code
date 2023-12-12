input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.chars

50.times do |i|
  input = input.slice_when { _1 != _2 }.to_a.flat_map { [_1.length.to_s, _1.first] }
  p input.size if i == 39
end

p input.size

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ').map(&:to_i) }

p input.count { _1[0] < _1[1] + _1[2] && _1[1] < _1[0] + _1[2] && _1[2] < _1[0] + _1[1] }

p [0, 1, 2].sum { |i| input.map { _1[i] }.each_slice(3).count { _1[0] < _1[1] + _1[2] && _1[1] < _1[0] + _1[2] && _1[2] < _1[0] + _1[1] } }

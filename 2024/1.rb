input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split.map(&:to_i) }

left = input.map { _1[0] }.sort
right = input.map { _1[1] }.sort

p (0...left.size).sum { (left[_1] - right[_1]).abs }

p left.sum { _1 * right.count(_1) }

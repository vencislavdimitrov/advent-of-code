input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split.map(&:to_i) }

safe = input.filter do |line|
  arr = line.each_cons(2).to_a.map { |a, b| a - b}
  arr.all? { [1, 2, 3].include?(_1) } || arr.all? { [-1, -2, -3].include?(_1) }
end

p safe.count

safe = input.filter do |line|
  lines = []
  (0...line.size).each do |i|
    lines << line.reject.with_index{|v, j| j == i }
  end

  lines = lines.map { _1.each_cons(2).to_a.map { |a, b| a - b } }
  lines.any? { |arr| arr.all? { [1, 2, 3].include?(_1) } || arr.all? { [-1, -2, -3].include?(_1) } }
end

p safe.count

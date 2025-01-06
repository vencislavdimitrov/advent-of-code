input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n").map { _1.split("\n").map(&:chars) }

locks, keys = input.partition { _1[0][0] == '#' }

locks = locks.map { _1.transpose.map { |col| col.index('.') - 1 } }
keys = keys.map { _1.transpose.map { |col| col.reverse.index('.') - 1 } }

p (keys.sum do |key|
  locks.count do |lock|
    key.each_with_index.all? { key[_2] + lock[_2] < 6 }
  end
end)

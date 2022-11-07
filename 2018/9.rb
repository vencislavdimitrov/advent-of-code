input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
players, points = input.scan(/\d+/).map(&:to_i)

def calculate(players, points)
  scores = {}
  table = [0, 4, 2, 1, 3]
  current = 1
  (5..points).each do |i|
    next if i < 4

    if i % 23 == 0
      scores[i % players] ||= []
      scores[i % players] << i
      scores[i % players] << table[current - 7]
      table.delete_at current - 7
      current = (current - 7) < 0 ? table.size - 6 + current : (current - 7)
      next
    end

    table.insert (current + 2) > table.size ? (current + 2) % table.size : current + 2, i
    current = (current + 3) > table.size ? (current + 3) % table.size : current + 2
  end

  scores.values.map(&:sum).max
end

p calculate players, points
p calculate players, points * 100

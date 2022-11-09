input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
number = input.to_i

grid = []
(1..300).each do |x|
  (1..300).each do |y|
    grid[x] ||= []
    grid[x][y] = ((((x + 10) * y + number) * (x + 10)) % 1000) / 100 - 5
  end
end

max = [0, [0, 0]]
(1...grid.size - 3).each do |x|
  (1...grid[x].size - 3).each do |y|
    power = grid[x][y] + grid[x][y + 1] + grid[x][y + 2] +
            grid[x + 1][y] + grid[x + 1][y + 1] + grid[x + 1][y + 2] +
            grid[x + 2][y] + grid[x + 2][y + 1] + grid[x + 2][y + 2]
    if max[0] < power
      max[0] = power
      max[1] = [x, y]
    end
  end
end

puts "#{max[1][0]},#{max[1][1]}"

max = [0, [0, 0, 0]]
powers = { 1 => grid.map(&:clone) }
(2...300).each do |size|
  (1...grid.size - size).each do |x|
    (1...grid[x].size - size).each do |y|
      powers[size] ||= []
      powers[size][x] ||= []
      powers[size][x][y] = powers[size-1][x][y] + grid[x + size - 1][y..y + size - 1].sum + grid[x..x + size - 1].map { _1[y + size - 1] }.sum
      if max[0] < powers[size][x][y]
        max[0] = powers[size][x][y]
        max[1] = [x, y, size]
      end
    end
  end
end

puts "#{max[1][0]},#{max[1][1]},#{max[1][2]}"

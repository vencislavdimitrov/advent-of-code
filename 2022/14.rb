input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.split(' -> ').map { |point| point.split(',').map(&:to_i) } }

grid = {}

input.each do |line|
  line.each_cons(2) do |from, to|
    x, y = from
    next_x, next_y = to
    grid[from] = '#'

    while [x, y] != [next_x, next_y]
      x += next_x <=> x
      y += next_y <=> y
      grid[[x, y]] = '#'
    end
  end
end

def simulate(grid, part2 = false)
  max_y = grid.keys.map(&:last).max + 2
  sand = grid.clone
  loop do
    return sand.size - grid.size if part2 && sand[[500, 0]]

    new_sand = [500, 0]
    loop do
      if new_sand[1] + 1 == max_y
        return sand.size - grid.size unless part2

        sand[new_sand] = '#'
        break
      end
      if sand[[new_sand[0], new_sand[1] + 1]].nil?
        new_sand[1] += 1
      elsif sand[[new_sand[0] - 1, new_sand[1] + 1]].nil?
        new_sand[0] -= 1
        new_sand[1] += 1
      elsif sand[[new_sand[0] + 1, new_sand[1] + 1]].nil?
        new_sand[0] += 1
        new_sand[1] += 1
      else
        sand[new_sand] = '#'
        break
      end
    end
  end
end

p simulate(grid)

p simulate(grid, true)

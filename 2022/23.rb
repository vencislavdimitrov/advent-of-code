input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

elves = {}
(0...input.size).each do |i|
  (0...input[i].size).each do |j|
    elves[[i, j]] = true if input[i][j] == '#'
  end
end

dirs = ['N', 'S', 'W', 'E']
1000.times do |t|
  new_elves = {}
  any_moved = false

  elves.each_key do |i, j|
    next if [
      [i - 1, j], [i - 1, j - 1], [i - 1, j + 1],
      [i, j - 1], [i, j + 1],
      [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]
    ].none? { elves[_1] }

    dirs.each do |dir|
      if dir == 'N' && !elves[[i - 1, j]] && !elves[[i - 1, j - 1]] && !elves[[i - 1, j + 1]]
        new_elves[[i - 1, j]] ||= []
        new_elves[[i - 1, j]] << [i, j]
        break
      elsif dir == 'S' && !elves[[i + 1, j]] && !elves[[i + 1, j - 1]] && !elves[[i + 1, j + 1]]
        new_elves[[i + 1, j]] ||= []
        new_elves[[i + 1, j]] << [i, j]
        break
      elsif dir == 'W' && !elves[[i, j - 1]] && !elves[[i - 1, j - 1]] && !elves[[i + 1, j - 1]]
        new_elves[[i, j - 1]] ||= []
        new_elves[[i, j - 1]] << [i, j]
        break
      elsif dir == 'E' && !elves[[i, j + 1]] && !elves[[i - 1, j + 1]] && !elves[[i + 1, j + 1]]
        new_elves[[i, j + 1]] ||= []
        new_elves[[i, j + 1]] << [i, j]
        break
      end
    end
  end

  dirs = dirs.rotate 1
  new_elves.each do |k, v|
    next unless v.size == 1

    any_moved = true
    elves.delete v.first
    elves[k] = true
  end

  unless any_moved
    p t + 1
    break
  end

  if t == 9
    x = elves.keys.map { _1[0] }.minmax
    y = elves.keys.map { _1[1] }.minmax
    p (x[1] - x[0] + 1) * (y[1] - y[0] + 1) - elves.keys.count
  end
end

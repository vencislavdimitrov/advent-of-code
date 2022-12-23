input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
map_raw, path_raw = input.split("\n\n")

map = {}
start_pos = nil

map_raw.split("\n").each_with_index do |line, i|
  line.chars.each_with_index do |c, j|
    if c != ' '
      map[[j + 1, i + 1]] = c
      start_pos ||= [j + 1, i + 1]
    end
  end
end

def change_dir(current_dir, turn)
  case current_dir
  when [0, 1] then turn == 'R' ? [-1, 0] : [1, 0]
  when [1, 0] then turn == 'R' ? [0, 1] : [0, -1]
  when [-1, 0] then turn == 'R' ? [0, -1] : [0, 1]
  when [0, -1] then turn == 'R' ? [1, 0] : [-1, 0]
  end
end

path = [0]
path_raw.strip.chars.each do |c|
  if c.to_i.to_s == c && path[-1].is_a?(Numeric)
    path[-1] *= 10
    path[-1] += c.to_i
  else
    path << (c.to_i.to_s == c ? c.to_i : c)
  end
end

pos = start_pos
dir = [1, 0]
path.each do |i|
  if i.is_a?(Numeric)
    i.times do
      new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
      cell = map[new_pos]
      if cell.nil?
        wrap_x = map.keys.select { _1[0] == new_pos[0] }.map(&:last)
        wrap_y = map.keys.select { _1[1] == new_pos[1] }.map(&:first)
        case dir
        when [1, 0] then new_pos = [wrap_y.min, new_pos[1]]
        when [-1, 0] then new_pos = [wrap_y.max, new_pos[1]]
        when [0, 1] then new_pos = [new_pos[0], wrap_x.min]
        when [0, -1] then new_pos = [new_pos[0], wrap_x.max]
        end
        cell = map[new_pos]
      end
      break if cell == '#'

      pos = new_pos
    end
  else
    dir = change_dir(dir, i)
  end
end

p (pos[1]) * 1000 + (pos[0]) * 4 + [[1, 0], [0, 1], [-1, 0], [0, -1]].index(dir)


def wrap(pos, dir)
  new_pos = pos
  new_dir = dir
  if dir[0] == 1
    if pos[0] == 150
      new_pos = [100, 151 - pos[1]]
      new_dir = [-1, 0]
    elsif pos[0] == 100
      if pos[1] >= 51 && pos[1] <= 100
        new_pos = [pos[1] + 50, 50]
        new_dir = [0, -1]
      elsif pos[1] >= 101 && pos[1] <= 150
        new_pos = [150, 151 - pos[1]]
        new_dir = [-1, 0]
      end
    elsif pos[0] == 50
      new_pos = [pos[1] - 100, 150]
      new_dir = [0, -1]
    end
  elsif dir[0] == -1
    if pos[0] == 51
      if pos[1] >= 1 && pos[1] <= 50
        new_pos = [1, 151 - pos[1]]
        new_dir = [1, 0]
      elsif pos[1] >= 51 && pos[1] <= 100
        new_pos = [pos[1] - 50, 101]
        new_dir = [0, 1]
      end
    elsif pos[0] == 1
      if pos[1] >= 101 && pos[1] <= 150
        new_pos = [51, 151 - pos[1]]
        new_dir = [1, 0]
      elsif pos[1] >= 151 && pos[1] <= 200
        new_pos = [pos[1] - 100, 1]
        new_dir = [0, 1]
      end
    end
  elsif dir[1] == 1
    if pos[1] == 50
      new_pos = [100, pos[0] - 50]
      new_dir = [-1, 0]
    elsif pos[1] == 150
      new_pos = [50, pos[0] + 100]
      new_dir = [-1, 0]
    elsif pos[1] == 200
      new_pos = [pos[0] + 100, 1]
      new_dir = [0, 1]
    end
  elsif dir[1] == -1
    if pos[1] == 1
      if pos[0] >= 51 && pos[0] <= 100
        new_pos = [1, pos[0] + 100]
        new_dir = [1, 0]
      elsif pos[0] >= 101 && pos[0] <= 150
        new_pos = [pos[0] - 100, 200]
        new_dir = [0, -1]
      end
    elsif pos[1] == 101
      new_pos = [51, pos[0] + 50]
      new_dir = [1, 0]
    end
  end

  [new_pos, new_dir]
end

pos = start_pos
dir = [1, 0]
path.each do |i|
  if i.is_a?(Numeric)
    i.times do
      new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
      cell = map[new_pos]
      if cell.nil?
        new_pos, new_dir = wrap pos, dir
        cell = map[new_pos]
        break if cell == '#'

        pos = new_pos
        dir = new_dir
      end

      break if cell == '#'

      pos = new_pos
    end
  else
    dir = change_dir(dir, i)
  end
end

p pos[1] * 1000 + pos[0] * 4 + [[1, 0], [0, 1], [-1, 0], [0, -1]].index(dir)

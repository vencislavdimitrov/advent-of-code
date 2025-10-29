input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split(', ')

def manhattan(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
dir = [-1, 0]
current = [0, 0]
input.each do |ins|
  dir = if ins[0] == 'R'
          dirs[(dirs.index(dir) + 1) % 4]
        else
          dirs[(dirs.index(dir) - 1) % 4]
        end
  current = [current[0] + ins[1..].to_i * dir[0], current[1] + ins[1..].to_i * dir[1]]
end
p manhattan([0, 0], current)

dir = [-1, 0]
current = [0, 0]
visited = [current.to_s]
input.each do |ins|
  dir = if ins[0] == 'R'
          dirs[(dirs.index(dir) + 1) % 4]
        else
          dirs[(dirs.index(dir) - 1) % 4]
        end
  ins[1..].to_i.times do
    current = [current[0] + dir[0], current[1] + dir[1]]
    if visited.include?(current.to_s)
      p manhattan([0, 0], current)
      exit
    end

    visited << current.to_s
  end
end

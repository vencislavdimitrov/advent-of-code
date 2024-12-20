input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")

start = [input.index { _1.include?('S')}, input[input.index { _1.include?('S')}].index('S')]

def bfs(input, start)
  dist = {start => 0}
  queue = [start]
  until queue.empty?
    cur = queue.shift
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dir|
      step = [cur[0] + dir[0], cur[1] + dir[1]]
      if !dist.key?(step) && input[step[0]][step[1]] != "#"
        queue << step
        dist[step] = dist[cur] + 1
      end
    end
  end
  dist
end

startDist = bfs(input, start)

cheats = []
startDist.keys.each do |cur|
  [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dir|
    step = [cur[0] + 2 * dir[0], cur[1] + 2 * dir[1]]
    if startDist.key?(step)
      if startDist[cur] > startDist[step]
        diff = startDist[cur] - startDist[step] - 2
        cheats << diff if diff > 0
      end
    end
  end
end
p cheats.count { _1 >= 100 }

cheats = []
startDist.keys.each do |cur|
  (-20..21).each do |i|
    (-20..21).each do |j|
      if i.abs + j.abs <= 20
        step = [cur[0] + i, cur[1] + j]
        if startDist.key?(step)
          if startDist[cur] > startDist[step]
            diff = startDist[cur] - startDist[step] - i.abs - j.abs
            cheats << diff if diff > 0
          end
        end
      end
    end
  end
end
p cheats.count { _1 >= 100 }

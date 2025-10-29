require 'digest'

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

def dfs(input)
  paths = []
  queue = [[0, 0, input]]
  until queue.empty?
    x, y, cur = queue.shift
    if [x, y] == [3, 3]
      paths << cur
      next
    end
    hex = Digest::MD5.hexdigest cur
    queue << [x - 1, y, cur + 'U'] if 'bcdef'.include?(hex[0]) && x > 0
    queue << [x + 1, y, cur + 'D'] if 'bcdef'.include?(hex[1]) && x < 3
    queue << [x, y - 1, cur + 'L'] if 'bcdef'.include?(hex[2]) && y > 0
    queue << [x, y + 1, cur + 'R'] if 'bcdef'.include?(hex[3]) && y < 3
  end
  paths
end

paths = dfs(input)
puts paths.min_by(&:size).sub(input, '')
p paths.max_by(&:size).size - input.size

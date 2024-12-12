input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:chars)

def adj(input, x, y)
  res = []
  res << [x-1, y] if x > 0
  res << [x+1, y] if x + 1 < input.size
  res << [x, y-1] if y > 0
  res << [x, y+1] if y + 1 < input[0].size

  res.filter { input[_1][_2] == input[x][y] }
end

region = {}
(0...input.size).each do |i|
  (0...input[i].size).each do |j|
    if !region[[i, j]]
      region[[i, j]] = [i, j]
      queue = adj(input, i, j)
      until queue.empty?
        cur = queue.pop
        region[cur] = [i, j]
        queue += adj(input, cur[0], cur[1]).filter { !region[_1] }
      end
    end
  end
end

inverted_region = region.each_with_object({}) { |(k,v), o| (o[v] ||= []) << k }

p inverted_region.sum { |k, v| v.size * v.sum { 4 - adj(input, _1, _2).size } }

p (inverted_region.sum do |k, v|
  asd = v.sum do
    res = 0
    res += 1 if !v.include?([_1 - 1, _2]) && !v.include?([_1, _2 - 1])
    res += 1 if !v.include?([_1 + 1, _2]) && !v.include?([_1, _2 - 1])
    res += 1 if !v.include?([_1 - 1, _2]) && !v.include?([_1, _2 + 1])
    res += 1 if !v.include?([_1 + 1, _2]) && !v.include?([_1, _2 + 1])
    res += 1 if v.include?([_1 - 1, _2]) && v.include?([_1, _2 - 1]) && !v.include?([_1 - 1, _2 - 1])
    res += 1 if v.include?([_1 + 1, _2]) && v.include?([_1, _2 - 1]) && !v.include?([_1 + 1, _2 - 1])
    res += 1 if v.include?([_1 - 1, _2]) && v.include?([_1, _2 + 1]) && !v.include?([_1 - 1, _2 + 1])
    res += 1 if v.include?([_1 + 1, _2]) && v.include?([_1, _2 + 1]) && !v.include?([_1 + 1, _2 + 1])
    res
  end
  v.size * asd
end)

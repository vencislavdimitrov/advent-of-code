input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n\n")

seeds = input[0].split(' ')[1..].map(&:to_i)
maps = input[1..].map { _1.split("\n")[1..].map { |e| e.split.map(&:to_i) } }

(0...seeds.size).each do |i|
  maps.each do |map|
    map.each do |line|
      if seeds[i] >= line[1] && seeds[i] < line[1] + line[2]
        seeds[i] = line[0] + seeds[i] - line[1]
        break
      end
    end
  end
end

p seeds.min


seeds = input[0].split(' ')[1..].map(&:to_i)
maps = maps.map { |map| map.map { _1 + [_1[0] + _1[2], _1[1] - _1[0]] } }

def in_seeds(seeds, n)
  seeds.each_slice(2) do |a, b|
    return true if n >= a && n < a + b
  end
  false
end

# runs in ~14 mins from 0
(100_000_000..).each do |i|
  n = i
  maps.reverse.each do |map|
    map.each do |line|
      if n >= line[0] && n < line[3]
        n += line[4]
        break
      end
    end
  end
  if in_seeds(seeds, n)
    p i
    break
  end
end

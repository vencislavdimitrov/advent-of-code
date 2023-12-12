input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

total_paper = 0
total_ribon = 0
input.each do |present|
  x, y, z = present.split('x').map(&:to_i)
  total_paper += (2 * x * y + 2 * x * z + 2 * y * z) + [x * y, x * z, y * z].min
  total_ribon += [x, y, z].min(2).sum * 2 + x * y * z
end

p total_paper
p total_ribon

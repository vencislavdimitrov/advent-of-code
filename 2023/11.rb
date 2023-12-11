input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

gaps_x = []
gaps_y = []

(0...input.size).reverse_each do |i|
  gaps_x << i if input[i].chars.all? { _1 == '.' }
end

(0...input[0].size).reverse_each do |i|
  gaps_y << i if input.map { _1[i] }.all? { _1 == '.' }
end

galaxies = []
(0...input.size).each do |i|
  (0...input[0].size).each do |j|
    galaxies << [i, j] if input[i][j] == '#'
  end
end

def distance(galaxies, gaps_x, gaps_y, n)
  distances = []
  (0...galaxies.size - 1).each do |i|
    (i + 1...galaxies.size).each do |j|
      ix = gaps_x.count { _1 < galaxies[i][0] } * n
      iy = gaps_y.count { _1 < galaxies[i][1] } * n
      jx = gaps_x.count { _1 < galaxies[j][0] } * n
      jy = gaps_y.count { _1 < galaxies[j][1] } * n
      distances << (galaxies[j][0] + jx - galaxies[i][0] - ix).abs + (galaxies[j][1] + jy - galaxies[i][1] - iy).abs
    end
  end
  distances.sum
end

p distance(galaxies, gaps_x, gaps_y, 1)
p distance(galaxies, gaps_x, gaps_y, 999_999)

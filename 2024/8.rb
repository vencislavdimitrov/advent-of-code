input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")

antenas = {}

input.each_with_index do |line, i|
  line.chars.each_with_index do |c, j|
    if c != '.'
      antenas[c] ||= []
      antenas[c] << [i, j]
    end
  end
end

antinodes = []
resonances = []
antenas.each do |_, antena|
  (0...antena.size-1).each do |i|
    (i + 1...antena.size).each do |j|
      x = antena[i][0] - antena[j][0]
      y = antena[i][1] - antena[j][1]

      antinode = [antena[i][0] + x, antena[i][1] + y]
      antinodes << antinode if antinode[0] >= 0 && antinode[1] >= 0 && antinode[0] < input.size && antinode[1] < input[0].size

      antinode = [antena[j][0] - x, antena[j][1] - y]
      antinodes << antinode if antinode[0] >= 0 && antinode[1] >= 0 && antinode[0] < input.size && antinode[1] < input[0].size

      (-input.size..input.size).each do |inc|
        antinode = [antena[i][0] + inc * x, antena[i][1] + inc * y]
        resonances << antinode if antinode[0] >= 0 && antinode[1] >= 0 && antinode[0] < input.size && antinode[1] < input[0].size
      end
    end
  end
end
p antinodes.uniq.count
p resonances.uniq.count

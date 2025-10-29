input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:split)

display = [
  (' ' * 50).chars,
  (' ' * 50).chars,
  (' ' * 50).chars,
  (' ' * 50).chars,
  (' ' * 50).chars,
  (' ' * 50).chars
]

input.each do |line|
  if line[0] == 'rect'
    x, y = line[1].split('x').map(&:to_i)
    (0...y).each do |i|
      (0...x).each do |j|
        display[i][j] = '#'
      end
    end
  elsif line[1] == 'row'
    display[line[2].split('=')[1].to_i].rotate!(-line[4].to_i)
  elsif line[1] == 'column'
    display = display.transpose
    display[line[2].split('=')[1].to_i].rotate!(-line[4].to_i)
    display = display.transpose
  end
end

p display.sum { _1.count("#") }

display.each { puts _1.join}

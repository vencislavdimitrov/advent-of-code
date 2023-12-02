input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.split(': ')[1] }.map { _1.split('; ') }

sum = 0
power = 0
input.each_with_index do |game, i|
  possible = true
  mins = {
    'red' => 0,
    'green' => 0,
    'blue' => 0
  }
  game.each do |set|
    limits = {
      'red' => 12,
      'green' => 13,
      'blue' => 14
    }
    set.split(', ').each do |color|
      limits[color.split[1]] -= color.split[0].to_i
      mins[color.split[1]] = [mins[color.split[1]], color.split[0].to_i].max
    end
    possible = false if limits.any? { _1[1] < 0 }
  end

  sum += (i + 1) if possible
  power += mins['red'] * mins['green'] * mins['blue']
end

p sum
p power

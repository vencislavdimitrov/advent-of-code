input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split(',')

current = [0, 0]
max_step = 0
input.each do |step|
  case step
  when 'n'
    current[1] += 2
  when 'nw'
    current[0] -= 1
    current[1] += 1
  when 'ne'
    current[0] += 1
    current[1] += 1
  when 's'
    current[1] -= 2
  when 'sw'
    current[0] -= 1
    current[1] -= 1
  when 'se'
    current[0] += 1
    current[1] -= 1
  end

  max_step = [max_step, current[0].abs + [0, (current[1].abs - current[0].abs) / 2].max].max
end

p current[0].abs + [0, (current[1].abs - current[0].abs) / 2].max
p max_step

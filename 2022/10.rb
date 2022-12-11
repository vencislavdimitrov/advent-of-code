input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

x = 1
cycles = 1
steps = []
crt = ''

input.each do |line|
  steps << cycles * x if [20, 60, 100, 140, 180, 220].include? cycles
  crt += [(cycles - 2) % 40, (cycles - 1) % 40, cycles % 40].include?(x) ? '#' : ' '

  if line == 'noop'
    cycles += 1
    next
  end

  y = line.split(' ')[1].to_i

  cycles += 1
  steps << cycles * x if [20, 60, 100, 140, 180, 220].include? cycles
  crt += [(cycles - 2) % 40, (cycles - 1) % 40, cycles % 40].include?(x) ? '#' : ' '

  cycles += 1
  x += y
end

p steps.sum

crt.chars.each_slice(40).map { puts _1.join }

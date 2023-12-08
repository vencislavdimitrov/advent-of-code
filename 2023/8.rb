input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
instructions, nodes = input.split("\n\n")

nodes = nodes.split("\n").map { _1.split(' = ') }.map { [_1[0], _1[1][1..-2].split(', ')] }.to_h

steps = 0
current_node = 'AAA'
loop do
  if current_node == 'ZZZ'
    p steps
    break
  end

  current_node = instructions[steps % instructions.size] == 'L' ? nodes[current_node][0] : nodes[current_node][1]
  steps += 1
end

loops = []
nodes.keys.select { _1[-1] == 'A' }.map do |current_node|
  steps = 0
  loop do
    if current_node[-1] == 'Z'
      loops << steps
      break
    end

    current_node = instructions[steps % instructions.size] == 'L' ? nodes[current_node][0] : nodes[current_node][1]
    steps += 1
  end
end

p loops.reduce(1, :lcm)

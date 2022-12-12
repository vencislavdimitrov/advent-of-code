input = File.read(File.basename(__FILE__).gsub('rb', 'input'))

def round(monkeys, part2 = false)
  (0...monkeys.size).each do |i|
    next if monkeys[i]['items'].empty?

    while monkeys[i]['items'].any?
      monkeys[i]['inspects'] += 1
      old = monkeys[i]['items'].shift
      old = eval monkeys[i]['operation']
      if part2
        old %= part2
      else
        old /= 3
      end
      (old % monkeys[i]['test']).zero? ? monkeys[monkeys[i]['true']]['items'] << old : monkeys[monkeys[i]['false']]['items'] << old
    end
  end
end

def parse_input(input)
  input.split("\n\n").map { _1.split("\n").map(&:strip) }.map do |m|
    {
      'items' => m[1].split(': ')[1].split(', ').map(&:to_i),
      'operation' => m[2].split('= ')[1],
      'test' => m[3].split(' ').last.to_i,
      'true' => m[4].split(' ').last.to_i,
      'false' => m[5].split(' ').last.to_i,
      'inspects' => 0
    }
  end
end

monkeys = parse_input input

20.times do
  round monkeys
end
p monkeys.map { _1['inspects'] }.max(2).inject(1, :*)


monkeys = parse_input input

lcm = monkeys.map { _1['test'] }.reduce(1, :lcm)
10_000.times do
  round monkeys, lcm
end
p monkeys.map { _1['inspects'] }.max(2).inject(1, :*)

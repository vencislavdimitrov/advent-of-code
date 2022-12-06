input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
stacks_input, instructions = input.split("\n\n").map { _1.split("\n") }

stacks = []
stacks_input.last.split(' ').count.times do |stack|
  stacks << stacks_input.map { _1[stack * 4 + 1] }.reject { _1 == ' ' }
end

instructions.each do |ins|
  ins = ins.split(' ')
  count = ins[1].to_i
  from = ins[3].to_i - 1
  to = ins[5].to_i - 1

  stacks[to].unshift(*stacks[from].shift(count).reverse)
end
puts stacks.map(&:first).join


stacks = []
stacks_input.last.split(' ').count.times do |stack|
  stacks << stacks_input.map { _1[stack * 4 + 1] }.reject { _1 == ' ' }
end

instructions.each do |ins|
  ins = ins.split(' ')
  count = ins[1].to_i
  from = ins[3].to_i - 1
  to = ins[5].to_i - 1

  stacks[to].unshift(*stacks[from].shift(count))
end
puts stacks.map(&:first).join

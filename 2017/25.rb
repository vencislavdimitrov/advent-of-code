input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")

current_state = input[0].scan(/Begin in state ([A-Z]+)./).first.first
steps = input[0].scan(/\d+/).first.to_i
states = {}

input[1..].each do |state|
  state = state.split("\n")
  states[state[0][-2]] = {
    0 => {:value => state[2][-2].to_i, :move => state[3][-3] == 'h' ? 1 : -1, :next_state => state[4][-2]},
    1 => {:value => state[6][-2].to_i, :move => state[7][-3] == 'h' ? 1 : -1, :next_state => state[8][-2]}
  }
end

tape = Hash.new(0)
cursor = 0
steps.times do
  next_state = states[current_state]
  value = tape[cursor]
  tape[cursor] = next_state[value][:value]
  current_state = next_state[value][:next_state]
  cursor += next_state[value][:move]
end

p tape.values.sum

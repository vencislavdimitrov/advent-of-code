require 'z3'

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ') }

def push_button(state, instruction)
  mask = [false] * state.size
  instruction.each { mask[_1] = true }
  state.map.with_index { _1 ^ mask[_2] }
end

def min_steps(goal, instructions)
  queue = [[goal.map { false }, 0]]

  until queue.empty?
    state, steps = queue.shift

    return steps if state == goal || steps > 20

    instructions.each { queue << [push_button(state, _1), steps + 1] }
    queue.uniq!
  end
end

steps = []
jolt_steps = []
input.each do |machine|
  goal = machine[0]
  goal = goal[1...-1].chars.map { _1 == '#' }
  instructions = machine[1...-1].map { _1[1...-1].split(',').map(&:to_i) }
  steps << min_steps(goal, instructions)

  jolts = machine[-1][1...-1].split(',').map(&:to_i)
  solver = Z3::Optimize.new
  presses = Z3.Int('presses')
  button_vars = instructions.map.with_index { Z3.Int('button' + _2.to_s) }
  jolts_from_buttons = Hash.new([])
  instructions.each_with_index do |button, i|
    button.each do |flip|
      jolts_from_buttons[flip] += [i]
    end
  end

  jolts_from_buttons.each do |k, v|
    solver.assert(jolts[k] == v.map { button_vars[_1] }.sum)
  end
  button_vars.each { solver.assert(_1 >= 0) }
  solver.assert(presses == button_vars.sum)
  solver.minimize(presses)
  solver.check
  jolt_steps << solver.model[presses].to_i
end
p steps.sum
p jolt_steps.sum

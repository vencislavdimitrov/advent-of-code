input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

input = input.map { _1.split(' -> ') }.map { [_1[1], _1[0].split] }.to_h

def calc(gate, state, input)
  return gate.to_i if gate.match(/^\d+$/)

  unless state.has_key?(gate)
    instruction = input[gate]
    if instruction.length == 1
      value = calc(instruction[0], state, input)
    else
      case instruction[-2]
      when 'RSHIFT'
        value = calc(instruction[0], state, input) >> calc(instruction[2], state, input)
      when 'LSHIFT'
        value = calc(instruction[0], state, input) << calc(instruction[2], state, input)
      when 'AND'
        value = calc(instruction[0], state, input) & calc(instruction[2], state, input)
      when 'OR'
        value = calc(instruction[0], state, input) | calc(instruction[2], state, input)
      when 'NOT'
        value = ~calc(instruction[1], state, input)
      end
    end
    state[gate] = value
  end

  state[gate]
end

part1 = calc('a', {}, input)
p part1

input['b'] = [part1.to_s]
p calc('a', {}, input)

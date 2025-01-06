inputs, operations = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n").map { _1.split("\n") }
inputs = inputs.map { _1.split(': ') }.map { [_1, _2.to_i == 1] }.to_h
operations = operations.map { _1.split(' ') }.map { [_5, [_1, _2, _3]] }.to_h

zs = operations.keys.select { _1.start_with?('z') }

def calc(operations, gate)
  return operations[gate] if [true, false].include?(operations[gate])

  case operations[gate][1]
  when 'AND'
    calc(operations, operations[gate][0]) && calc(operations, operations[gate][2])
  when 'OR'
    calc(operations, operations[gate][0]) || calc(operations, operations[gate][2])
  when 'XOR'
    calc(operations, operations[gate][0]) ^ calc(operations, operations[gate][2])
  end
end
p zs.sort.reverse.map { calc(operations.merge(inputs), _1) }.map { _1 ? 1 : 0}.join.to_i(2)

start = inputs.map { [_1[0], true] }.to_h
final = "z#{start.keys.sort[-1].scan(/\d+/)[0].to_i + 1}"
gates = {}
bad = []
start_gates = {'x00' => true, 'y00' => true}
operations.each { |gate, ops|
  left, op, right = ops
  if gates[gate]
    gates[gate][0] = op
    gates[gate][1] = [left, right]
  else
    gates[gate] = [op, [left, right], []]
  end
  [left, right].each { gates[_1] ? gates[_1][2].push(gate) : gates[_1] = [nil, [], [gate]] }
}
gates.each do |k, v|
  if k.start_with?('z')
    if k == final
      bad.push(k) if v[0] != 'OR'
    else
      if v[0] != 'XOR' || v[1].any? { start[_1] && _1.scan(/\d+/) != k.scan(/\d+/) }
        bad.push(k)
      else
        v[1].each do |p|
          if gates[p][1].any? { start[_1] }
            bad.push(p) if gates[p][0] != 'XOR' && !gates[p][1].any? { start_gates[_1] }
          else
            bad.push(p) if gates[p][0] != 'OR' && !start[p]
          end
        end
      end
    end
  else
    if v[0] == 'OR'
      v[1].each { bad.push(_1) if gates[_1][0] != 'AND' }
    end
  end
end
puts bad.sort.join(',')

require 'JSON'

input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
samples, program = input.split "\n\n\n"

samples = samples.split("\n\n").map { _1.split("\n") }.map { [JSON.parse(_1[0].gsub('Before: ', '')), _1[1].split(' ').map(&:to_i), JSON.parse(_1[2].gsub('After: ', ''))] }
program = program.split("\n").map { _1.split(' ').map(&:to_i) }
opcodes = [:addr, :addi, :mulr, :muli, :banr, :bani, :borr, :bori, :setr, :seti, :gtir, :gtri, :gtrr, :eqir, :eqri, :eqrr]

def run(opcode, registers, params)
  case opcode
  when :addr # (add register) stores into register C the result of adding register A and register B.
    registers[params[3]] = registers[params[1]] + registers[params[2]]
  when :addi # (add immediate) stores into register C the result of adding register A and value B.
    registers[params[3]] = registers[params[1]] + params[2]
  when :mulr # (multiply register) stores into register C the result of multiplying register A and register B.
    registers[params[3]] = registers[params[1]] * registers[params[2]]
  when :muli # (multiply immediate) stores into register C the result of multiplying register A and value B.
    registers[params[3]] = registers[params[1]] * params[2]
  when :banr # (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
    registers[params[3]] = registers[params[1]] & registers[params[2]]
  when :bani # (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
    registers[params[3]] = registers[params[1]] & params[2]
  when :borr # (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
    registers[params[3]] = registers[params[1]] | registers[params[2]]
  when :bori # (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
    registers[params[3]] = registers[params[1]] | params[2]
  when :setr # (set register) copies the contents of register A into register C. (Input B is ignored.)
    registers[params[3]] = registers[params[1]]
  when :seti # (set immediate) stores value A into register C. (Input B is ignored.)
    registers[params[3]] = params[1]
  when :gtir # (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
    registers[params[3]] = params[1] > registers[params[2]] ? 1 : 0
  when :gtri # (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
    registers[params[3]] = registers[params[1]] > params[2] ? 1 : 0
  when :gtrr # (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
    registers[params[3]] = registers[params[1]] > registers[params[2]] ? 1 : 0
  when :eqir # (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
    registers[params[3]] = params[1] == registers[params[2]] ? 1 : 0
  when :eqri # (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
    registers[params[3]] = registers[params[1]] == params[2] ? 1 : 0
  when :eqrr # (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
    registers[params[3]] = registers[params[1]] == registers[params[2]] ? 1 : 0
  end

  registers
end

count = samples.count do |sample|
  opcodes.count { run(_1, sample[0].clone, sample[1].clone) == sample[2] } >= 3
end
p count

number_groups = samples.group_by { _1[1][0] }
number_map = {}

number_groups.each do |k, v|
  number_map[k] = opcodes.select { |opcode| v.all? { run(opcode, _1[0].clone, _1[1].clone) == _1[2] } }
end

while number_map.values.any? { _1.size > 1 }
  mapped = number_map.values.select { _1.size == 1 }.flatten
  number_map.each_value do |v|
    v.delete_if { mapped.include?(_1) } if v.size > 1
  end
end

number_map = number_map.map { [_1, _2.first] }.to_h
registers = [0, 0, 0, 0]
program.each do |instruction|
  registers = run(number_map[instruction[0]], registers, instruction)
end
p registers[0]

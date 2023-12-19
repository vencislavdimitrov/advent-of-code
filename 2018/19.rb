input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")
ip_reg = input[0].split(' ')[1].to_i
instructions = input[1..].map { _1.split(' ') }.map { [_1[0].to_sym, [0] + _1[1..].map(&:to_i)] }

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

ip = 0
regs = [0] * 6
loop do
  instruction = instructions[ip]
  run(instruction[0], regs, instruction[1])
  regs[ip_reg] += 1
  ip = regs[ip_reg]
  break if ip >= instructions.size
end
p regs[0]

# ip = 0
# regs = [1, 0, 0, 0, 0, 0]
# loop do
#   instruction = instructions[ip]
#   run(instruction[0], regs, instruction[1])
#   regs[ip_reg] += 1
#   ip = regs[ip_reg]
#   break if ip >= instructions.size
# end
# p regs[0]

### find the sum of all divisors of regs[1] = 10551315
p [1, 3, 5, 15, 31, 93, 155, 465, 22_691, 68_073, 113_455, 340_365, 703_421, 2_110_263, 3_517_105, 10_551_315].sum

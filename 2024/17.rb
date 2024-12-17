registers, program = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n")
registers = registers.scan(/(\d+)/).flatten.map(&:to_i)
program = program.split(' ')[1].split(',').map(&:to_i)

def combo(operand, registers)
  case operand
  when 0,1,2,3
    operand
  when 4
    registers[0]
  when 5
    registers[1]
  when 6
    registers[2]
  end
end

def run(program, registers)
  pointer = 0
  output = []
  while pointer < program.size
    opcode = program[pointer]
    operand = program[pointer + 1]
    case opcode
    when 0
      registers[0] /= 2 ** combo(operand, registers)
    when 1
      registers[1] = registers[1] ^ operand
    when 2
      registers[1] = combo(operand, registers) % 8
    when 3
      if registers[0] != 0
        pointer = operand
        next
      end
    when 4
      registers[1] = registers[1] ^ registers[2]
    when 5
      output << combo(operand, registers) % 8
    when 6
      registers[1] = registers[0] / (2 ** combo(operand, registers))
    when 7
      registers[2] = registers[0] / (2 ** combo(operand, registers))
    end
    pointer += 2
  end
  output
end

puts run(program, registers).join(',')

matched = 1
i = 0
loop do
  output = run(program, [i, 0, 0]);

  if output == program.last(matched)
    matched += 1;

    break if matched > program.size

    i <<= 3
    next
  end

  i += 1
end
p i

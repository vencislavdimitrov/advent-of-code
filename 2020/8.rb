input_file = File.read('./8.input').split("\n")

def run_console(input)
  current_instruction = 0
  accumulator = 0
  visited = []
  until visited.include? current_instruction
    break if input[current_instruction].nil?

    visited << current_instruction
    op, index = input[current_instruction].split
    case op
    when 'acc'
      accumulator += index.to_i
      current_instruction += 1
    when 'jmp'
      current_instruction += index.to_i
    when 'nop'
      current_instruction += 1
    end
  end
  [accumulator, current_instruction]
end

pp run_console(input_file)[0]

input_file.each_with_index do |line, index|
  next if line.split[0] == 'acc'

  input = input_file.clone
  input[index] = line.split[0] == 'jmp' ? "nop #{line.split[1]}" : "jmp #{line.split[1]}"

  accumulator, current_instruction = run_console(input)

  pp accumulator if current_instruction == input.size
end

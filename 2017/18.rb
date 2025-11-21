input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ') }

def value(x, registers)
  x.to_i.to_s == x ? x.to_i : registers[x]
end

def run(input, registers, i, part1)
  loop do
    instruction = input[i]
    case instruction[0]
    when 'snd'
      return [value(instruction[1], registers), i + 1] unless part1
      registers['queue'] << value(instruction[1], registers)
    when 'set'
      registers[instruction[1]] = value(instruction[2], registers)
    when 'add'
      registers[instruction[1]] += value(instruction[2], registers)
    when 'mul'
      registers[instruction[1]] *= value(instruction[2], registers)
    when 'mod'
      registers[instruction[1]] %= value(instruction[2], registers)
    when 'jgz'
      if value(instruction[1], registers) > 0
        i += value(instruction[2], registers) - 1
      end
    when 'rcv'
      if registers['queue'].empty?
        return [nil, i] unless part1
      else
        return [registers['queue'].last, i + 1] if part1
        registers[instruction[1]] = registers['queue'].shift
      end
    end

    i += 1
  end
end

registers = Hash.new(0)
registers['queue'] = []
p run(input, registers, 0, true)[0]

registers0 = Hash.new(0)
registers0['p'] = 0
registers0['queue'] = []
registers1 = Hash.new(0)
registers1['p'] = 1
registers1['queue'] = []

i0, i1 = 0, 0
count = 0
loop do
  value0, i0 = run(input, registers0, i0, false)
  unless value0.nil?
    registers1['queue'] << value0
  end
  value1, i1 = run(input, registers1, i1, false)
  unless value1.nil?
    registers0['queue'] << value1
    count += 1
  end

  break if value0.nil? && value1.nil?
end

p count

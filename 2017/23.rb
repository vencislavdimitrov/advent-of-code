input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ') }

def value(x, registers)
  x.to_i.to_s == x ? x.to_i : registers[x]
end

def run(input, registers, i)
  muls = 0
  loop do
    instruction = input[i]
    break if instruction.nil?
    case instruction[0]
    when 'set'
      registers[instruction[1]] = value(instruction[2], registers)
    when 'sub'
      registers[instruction[1]] -= value(instruction[2], registers)
    when 'mul'
      muls += 1
      registers[instruction[1]] *= value(instruction[2], registers)
    when 'jnz'
      if value(instruction[1], registers) != 0
        i += value(instruction[2], registers) - 1
      end
    end

    i += 1
  end
  muls
end

registers = Hash.new(0)
p run(input, registers, 0)

b = 93
c = 93
d = 0
f = 0
g = 0
h = 0
b = b * 100 + 100000
c = b + 17000
loop do
  f = 1
  d = 2
  i = d
  loop do
    break if i * i >= b
    if (b % i == 0)
      f = 0
      break
    end
    i += 1
  end
  h += 1 if (f == 0)
  g = b - c
  b += 17
  break if g == 0
end

p h

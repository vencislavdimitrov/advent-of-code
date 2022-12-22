input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

monkeys = input.map { _1.split(': ') }.to_h

def calculate(monkeys, current)
  return monkeys[current].to_f if monkeys[current].to_i.to_s == monkeys[current]

  expr = monkeys[current].split(' ')
  eval("(#{calculate(monkeys, expr[0])} #{expr[1]} #{calculate(monkeys, expr[2])})")
end

p calculate(monkeys, 'root').to_i

monkey1, _, monkey2 = monkeys['root'].split(' ')
monkey2_number = calculate(monkeys, monkey2)
i = 0
mult = 2**42
loop do
  monkeys['humn'] = i.to_s
  monkey1_number = calculate(monkeys, monkey1)
  if monkey1_number == monkey2_number
    p i
    break
  end
  if monkey1_number > monkey2_number
    i += mult
  else
    i -= mult
    mult /= 2 unless mult == 1
  end
end

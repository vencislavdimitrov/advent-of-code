input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

def run(input, regs)
  i = 0
  while i < input.size
    ins = input[i].split
    case ins[0]
    when 'hlf'
      regs[ins[1]] /= 2
      i += 1
    when 'tpl'
      regs[ins[1]] *= 3
      i += 1
    when 'inc'
      regs[ins[1]] += 1
      i += 1
    when 'jmp'
      i += ins[1].to_i
    when 'jie'
      i += regs[ins[1][0]].even? ? ins[2].to_i : 1
    when 'jio'
      i += regs[ins[1][0]] == 1 ? ins[2].to_i : 1
    end
  end
  regs
end

p run(input, { 'a' => 0, 'b' => 0 })['b']
p run(input, { 'a' => 1, 'b' => 0 })['b']

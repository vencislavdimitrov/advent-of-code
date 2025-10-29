input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:split)


def assembunny(regs, input)
  current_index = 0
  while current_index < input.size
    current = input[current_index]
    case current[0]
    when 'cpy' then
      if ['a', 'b', 'c', 'd'].include?(current[1])
        regs[current[2]] = regs[current[1]]
      else
        regs[current[2]] = current[1].to_i
      end
    when 'inc' then
      regs[current[1]] += 1
    when 'dec' then
      regs[current[1]] -= 1
    when 'jnz' then
      if ['a', 'b', 'c', 'd'].include?(current[1])
        current_index += (current[2].to_i - 1) if regs[current[1]] != 0
      else
        current_index += (current[2].to_i - 1) if current[1].to_i != 0
      end
    end

    current_index += 1
  end

  regs['a']
end

p assembunny({'a' => 0, 'b' => 0, 'c' => 0, 'd' => 0}, input)

p assembunny({'a' => 0, 'b' => 0, 'c' => 1, 'd' => 0}, input)

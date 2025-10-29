input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:split)

def assembunny(regs, input)
  current_index = 0
  while current_index < input.size
    current = input[current_index]
    case current[0]
    when 'cpy' then
      next if current.size != 3
      if ['a', 'b', 'c', 'd'].include?(current[1])
        regs[current[2]] = regs[current[1]]
      else
        regs[current[2]] = current[1].to_i
      end
    when 'inc' then
      next if current.size != 2
      regs[current[1]] += 1
    when 'dec' then
      next if current.size != 2
      regs[current[1]] -= 1
    when 'jnz' then
      next if current.size != 3
      inc =
        if ['a', 'b', 'c', 'd'].include?(current[2])
          regs[current[2]].to_i - 1
        else
          current[2].to_i - 1
        end
      if ['a', 'b', 'c', 'd'].include?(current[1])
        current_index += inc if regs[current[1]] != 0
      else
        current_index += inc if current[1].to_i != 0
      end
    when 'tgl'
      next if current.size != 2
      if ['a', 'b', 'c', 'd'].include?(current[1])
        ind = current_index + regs[current[1]]
      else
        ind = current_index + current[1].to_i
      end
      if ind >= 0 && ind < input.size
        if input[ind].size == 2
          if input[ind][0] != 'inc'
            input[ind][0] = 'inc'
          else
            input[ind][0] = 'dec'
          end
        elsif input[ind].size == 3
          if input[ind][0] != 'jnz'
            input[ind][0] = 'jnz'
          else
            input[ind][0] = 'cpy'
          end
        end
      end
    end

    current_index += 1
  end

  regs['a']
end

p assembunny({'a' => 7, 'b' => 0, 'c' => 0, 'd' => 0}, input)

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:split)
p assembunny({'a' => 12, 'b' => 0, 'c' => 0, 'd' => 0}, input)

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")
instructions = input[1..].map { _1.split(' ') }.map { [_1[0].to_sym, [0] + _1[1..].map(&:to_i)] }

def run(n)
  reg3 = 0
  loop do
    reg1 = reg3 | 65_536
    reg3 = n

    loop do
      reg3 += (reg1 & 255)
      reg3 &= 16_777_215
      reg3 *= 65_899
      reg3 &= 16_777_215
      return reg3 if reg1 < 256

      reg1 /= 256
    end
  end
end

p run(instructions[7][1][1])

def run2(n)
  seen = []
  reg3 = 0
  last_reg3 = 0
  loop do
    reg1 = reg3 | 65_536
    reg3 = n

    loop do
      reg3 += (reg1 & 255)
      reg3 &= 16_777_215
      reg3 *= 65_899
      reg3 &= 16_777_215
      if reg1 < 256
        return last_reg3 if seen.include?(reg3)

        seen << reg3
        last_reg3 = reg3
        break

      end

      reg1 /= 256
    end
  end
end

p run2(instructions[7][1][1])

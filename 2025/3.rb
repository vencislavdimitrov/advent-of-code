input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

def max_jolt(bank, jolt, size)
  return jolt.to_i if jolt.size == size

  if bank.size == size - jolt.size
    (jolt + bank).to_i
  end

  (1..9).reverse_each do |i|
    battery = bank.index(i.to_s)
    if battery && bank.size - battery + jolt.size >= size
      return max_jolt(bank[battery+1..], jolt + i.to_s, size)
    end
  end
end

p input.sum { max_jolt(_1, '', 2) }
p input.sum { max_jolt(_1, '', 12) }


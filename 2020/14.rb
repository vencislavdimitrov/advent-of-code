input_file = File.read('./14.input').split('mask = ').map { |l| l.split "\n" }[1..]

memory = {}
input_file.each do |ins|
  mask = ins[0]
  zeros = mask.gsub('X', '0').to_i 2
  ones = mask.gsub('X', '1').to_i 2

  ins[1..].each do |value|
    address, number = value.gsub(/\d+/).map(&:to_i)
    memory[address] = (number | zeros) & ones
  end
end

pp memory.values.sum

def persist(mem, address, number, mask, index)
  if index == address.length
    mem[address] = number
    return
  end

  case mask[index]
  when '0'
    persist(mem, address, number, mask, index + 1)
  when '1'
    address = address.clone
    address[index] = '1'
    persist(mem, address, number, mask, index + 1)
  when 'X'
    address1 = address.clone
    address1[index] = '0'
    address2 = address.clone
    address2[index] = '1'
    persist(mem, address1, number, mask, index + 1)
    persist(mem, address2, number, mask, index + 1)
  end
end

memory = {}
input_file.each do |ins|
  mask = ins[0]

  ins[1..].each do |value|
    address, number = value.gsub(/\d+/).map(&:to_i)
    address = address.to_s(2).rjust(mask.length, '0')
    persist(memory, address, number, mask, 0)
  end
end

pp memory.values.sum

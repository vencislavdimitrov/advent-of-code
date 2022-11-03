input = '137826495'.chars.map(&:to_i)

current = input[0]
100.times do
  three = input[1..3]
  input = [input[0]] + input[4..]
  min = input.min
  max = input.max
  destination = current - 1
  while input.index(destination).nil?
    destination -= 1
    destination = max if destination < min
  end
  destination_ind = input.index(destination)
  input = input[0..destination_ind] + three + input[destination_ind + 1..]
  input = input[1..] + [input[0]]
  current = input[0]
end

ind = input.index(1)
pp (input[ind..] + input[0...ind])[1..].join

input = '137826495'.chars.map(&:to_i)
cups = (1..1_000_001).to_a
(0...input.size - 1).each do |i|
  cups[input[i]] = input[i + 1]
end
cups[cups.size - 1] = input.first
cups[input.last] = 10
current = input[0]

10_000_000.times do
  one = cups[current]
  two = cups[one]
  three = cups[two]

  destination = current
  loop do
    destination -= 1
    destination = cups.size - 1 if destination < 1
    break unless [one, two, three].include?(destination)
  end

  cups[current] = cups[three]
  cups[three] = cups[destination]
  cups[destination] = one

  current = cups[current]
end

pp cups[1] * cups[cups[1]]

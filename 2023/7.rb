input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.split(' ') }

def trans(hand, part2 = false)
  hand.chars.map do |c|
    case c
    when 'T' then 10
    when 'J' then part2 ? 0 : 11
    when 'Q' then 12
    when 'K' then 13
    when 'A' then 14
    else c.to_i end
  end
end

def comp(a, b)
  order = [
    [1, 1, 1, 1, 1],
    [1, 1, 1, 2],
    [1, 2, 2],
    [1, 1, 3],
    [2, 3],
    [1, 4],
    [5]
  ]
  o1 = order.index(trans(a).tally.map { _1[1] }.sort) <=> order.index(trans(b).tally.map { _1[1] }.sort)
  if o1 == 0
    trans(a) <=> trans(b)
  else
    o1
  end
end
p input.sort { comp(_1[0], _2[0]) }.each_with_index.map { |v, i| (i + 1) * v[1].to_i }.sum

def comp2(a, b)
  order = [
    [1, 1, 1, 1, 1],
    [1, 1, 1, 2],
    [1, 2, 2],
    [1, 1, 3],
    [2, 3],
    [1, 4],
    [5]
  ]
  max_a = a
  max_b = b
  ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A'].each do |c|
    temp_a = a.tr('J', c)
    temp_b = b.tr('J', c)
    max_a = comp(max_a, temp_a) < 0 ? temp_a : max_a
    max_b = comp(max_b, temp_b) < 0 ? temp_b : max_b
  end
  o1 = order.index(trans(max_a).tally.map { _1[1] }.sort) <=> order.index(trans(max_b).tally.map { _1[1] }.sort)
  if o1 == 0
    trans(a, true) <=> trans(b, true)
  else
    o1
  end
end
p input.sort { comp2(_1[0], _2[0]) }.each_with_index.map { |v, i| (i + 1) * v[1].to_i }.sum

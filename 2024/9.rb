input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.chars.map(&:to_i)

indexes = [input[0]]
(1...input.size).each do |i|
  indexes[i] = indexes[i-1] + input[i]
end

def at_index(input, indexes, ind)
  i = indexes.index { _1 > ind }
  return false if i.odd?
  i / 2
end

cur = 0
last = indexes.last - 1
sum = 0

while cur <= last
  block = at_index(input, indexes, cur)
  if block
    sum += block * cur
  else
    until at_index(input, indexes, last)
      last -= 1
    end
    next if last < cur
    sum += at_index(input, indexes, last) * cur
    last -= 1
  end
  cur += 1
end
p sum


input = input.map.with_index { |block, i| [i.odd? ? nil : i/2, block] }.reject { _2 == 0 }

res = []
until input.empty?
  id, n = input.pop
  i = input.index { _1.nil? && _2 >= n }

  if id.nil?
    res << [nil, n]
  elsif i
    input[i, 1] = [[id, n], [nil, input[i][1] - n]]
    res << [nil, n]
  else
    res << [id, n]
  end
end

p res.reverse.map { [_1.nil? ? 0 : _1] * _2 }.flatten.map.with_index { _1 * _2 }.sum

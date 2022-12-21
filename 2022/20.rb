input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map(&:to_i)

indexes = (0...input.size).to_a
(0...input.size).each do |i|
  idx = indexes.index(i)
  indexes.delete_at idx
  indexes.insert (idx + input[i]) % indexes.size, i
end
first_element = indexes.index(input.index(0))
p [1000, 2000, 3000].map { input[indexes[(first_element + _1) % indexes.size]] }.sum

input = input.map { _1 * 811_589_153 }
indexes = (0...input.size).to_a
10.times do |t|
  (0...input.size).each do |i|
    idx = indexes.index(i)
    indexes.delete_at idx
    indexes.insert (idx + input[i]) % indexes.size, i
  end
end

first_element = indexes.index(input.index(0))
p [1000, 2000, 3000].map { input[indexes[(first_element + _1) % indexes.size]] }.sum

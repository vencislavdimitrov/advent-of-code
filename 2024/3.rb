input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

p input.scan(/mul\((\d+),(\d+)\)/).map { _1.map(&:to_i).reduce(1, :*) }.sum

enabled = true
p (input.scan(/mul\(\d+,\d+\)|do\(\)|don't\(\)/).map do |el|
  if el == 'do()'
    enabled = true
    0
  elsif el == "don't()"
    enabled = false
    0
  elsif enabled
    el.scan(/(\d+),(\d+)/).map { _1.map(&:to_i).reduce(1, :*) }.first
  end
end.compact.sum)

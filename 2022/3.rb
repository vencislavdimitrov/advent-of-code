input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

def priority(item)
  if item == item.downcase
    item.ord - 'a'.ord + 1
  else
    item.ord - 'A'.ord + 27
  end
end

sum = input.map do |line|
  item = (line[0...line.size / 2].chars & line[line.size / 2..].chars).first
  priority item
end.sum

p sum

sum = input.each_slice(3).map do |one, two, three|
  item = (one.chars & two.chars & three.chars).first
  priority item
end.sum

p sum

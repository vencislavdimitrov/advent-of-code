input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
# input = '2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2'
input = input.strip.split.map(&:to_i)

def process(list)
  num_children = list.shift
  num_metadata = list.shift
  [(0..num_children - 1).to_a.map { process(list) }, list.shift(num_metadata)]
end

p process(input.clone).flatten.sum

def value(node)
  node[0].any? ? node[1].map { |m| m > 0 && (m - 1) < node[0].size ? value(node[0][m - 1]) : 0 }.sum : node[1].sum
end

puts value(process(input))

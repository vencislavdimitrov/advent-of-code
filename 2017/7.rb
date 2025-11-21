input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' -> ') }

leafs = input.reject { _1[1].nil? }.flat_map { _1[1].split(', ') }
puts input.find { !leafs.include?(_1[0].split(' ').first) }.first.split(' ').first

tree = {}
input.each do |node|
  node_name, weight = node[0].split(' (')
  tree[node_name] = [weight[..-1].to_i, node[1]&.split(', ') || []]
end

def weight(tree, node)
  tree[node][0] + tree[node][1].sum { weight(tree, _1) }
end

unbalanced = tree.keys.find { |node| tree[node][1].map { weight(tree, _1) }.uniq.size > 1 && tree[node][1].all? { |child| tree[child][1].map { weight(tree, _1) }.uniq.size == 1 } }
adj = tree[unbalanced][1].map { weight(tree, _1) }.uniq.reduce(&:-)
unbalanced_node = tree[unbalanced][1].find { |node| tree[unbalanced][1].map { weight(tree, _1) }.count(weight(tree, node)) == 1 }
p tree[unbalanced_node][0] + adj

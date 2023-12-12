input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:to_i)

def entanglement(input, target)
  (1...input.size).each do |i|
    res = input.combination(i).select { _1.sum == target }.sort_by { _1.size * 1000 + _1.inject(:*) }
    return res[0].inject(:*) unless res.empty?
  end
end

p entanglement(input, input.sum / 3)
p entanglement(input, input.sum / 4)

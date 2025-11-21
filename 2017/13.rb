input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(': ').map(&:to_i) }.to_h
firewall = Range.new(*input.map { _1[0] }.minmax).to_a.map { [_1, input[_1] || 0 ]}.to_h


def pass_packet(firewall, delay)
  sum = 0
  firewall.each.map do |depth, range|
    if (depth + delay) % ((range - 1) * 2) == 0
      return 1 if delay > 0 && range != 0
      sum += depth * range
    end
  end
  sum
end

p pass_packet(firewall, 0)

(1..).each do |i|
  if pass_packet(firewall, i) == 0
    p i
    break
  end
end

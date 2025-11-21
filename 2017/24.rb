input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split('/').map(&:to_i) }

$longest_bridge = [0, 0]
def build_bridge(bridge, unused)
  if bridge.size > $longest_bridge[0] || (bridge.size == $longest_bridge[0] && bridge.flatten.sum > $longest_bridge[1])
    $longest_bridge = [bridge.size, bridge.flatten.sum]
  end

  if unused.empty?
    return bridge.flatten.sum
  end

  if bridge.empty?
    return unused.filter { _1[0] == 0 || _1[1] == 0 }.map { build_bridge([_1[0] == 0 ? _1 : [_1[1], _1[0]]], unused - [_1]) }.max
  end

  ([bridge.flatten.sum] + unused.filter { _1[0] == bridge.last[1] || _1[1] == bridge.last[1] }.map { build_bridge(bridge + [_1[0] == bridge.last[1] ? _1 : [_1[1], _1[0]]], unused - [_1]) }).max
end

p build_bridge([], input)
p $longest_bridge[1]

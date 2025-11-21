input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' <-> ') }.map { [_1[0].to_i, _1[1].split(',').map(&:to_i)]}.to_h

groups = []

until (input.keys - groups.flatten).empty?
  groups << []
  queue = [(input.keys - groups.flatten)[0]]

  until queue.empty?
    current = queue.pop

    next if groups.last.include?(current)
    groups.last << current

    queue += input[current].filter { !groups.last.include?(_1) }
  end
end

p groups[0].size
p groups.size

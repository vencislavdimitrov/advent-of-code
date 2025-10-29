input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { [_1.split[3], _1.split.last[...-1]].map(&:to_i) }

def calc_time(input)
  time = 0
  loop do
    if input.map.with_index.all? { |disc, i| (disc[1] + time + i + 1) % disc[0] == 0 }
      return time
    end
    time += 1
  end
end

p calc_time(input)
input << [11, 0]
p calc_time(input)

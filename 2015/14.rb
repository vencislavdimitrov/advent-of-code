input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip
input = input.split("\n").map { _1.split(' ') }.map { [_1[0], _1[3].to_i, _1[6].to_i, _1[13].to_i] }

def distance(deer, seconds)
  seconds / (deer[2] + deer[3]) * deer[1] * deer[2] + [seconds % (deer[2] + deer[3]), deer[2]].min * deer[1]
end

p input.map { distance(_1, 2503) }.max

deers = input.map { [_1[0], 0] }.to_h
2502.times do |t|
  deer = input.map { [_1[0], distance(_1, t+1)] }.max_by { _1[1] }
  deers[deer[0]] += 1
end
p deers.values.max

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' -> ') }
types = input.map { [_1[0][1..], _1[0][0]] }.to_h
input = input.map { [_1[1..], _2.split(', ')] }.to_h

state = input.keys.map { [_1, false] }.to_h
acc = {}
types.select { _2 == '&' }.each_key do |t|
  acc[t] ||= {}
  input.each do |k, v|
    v.each do |from|
      acc[t][k] = false if from == t
    end
  end
end

low = 0
high = 0
t = 0
cache = {}
steps = []
rx = %w[br fk lf rz]
loop do
  queue = [['roadcaster', '', false]]
  until queue.empty?
    to, from, pulse = queue.shift

    if pulse
      high += 1
    else
      steps << t - cache[to] if rx.include?(to) && cache[to]
      cache[to] = t
      low += 1
    end

    if steps.size == rx.size
      p steps.reduce(1, :lcm)
      exit
    end

    next unless input[to]

    case types[to]
    when 'b'
      input[to].each do |new_to|
        queue << [new_to, to, pulse]
      end
    when '%'
      unless pulse
        state[to] = !state[to]
        pulse = state[to]
        input[to].each do |new_to|
          queue << [new_to, to, pulse]
        end
      end
    when '&'
      acc[to][from] = pulse
      pulse = !acc[to].values.all? { _1 == true }
      input[to].each do |new_to|
        queue << [new_to, to, pulse]
      end
    end
  end
  t += 1
  p low * high if t == 1000
end

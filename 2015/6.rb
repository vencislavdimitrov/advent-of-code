input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")
             .map { _1.match(/(turn on|turn off|toggle) (\d+,\d+) through (\d+,\d+)/) }
             .map { [_1[1], _1[2].split(',').map(&:to_i), _1[3].split(',').map(&:to_i)] }

lights = {}
1000.times do |i|
  1000.times do |j|
    lights[[i, j]] = false
  end
end

input.each do |order|
  (order[1][0]..order[2][0]).each do |i|
    (order[1][1]..order[2][1]).each do |j|
      lights[[i, j]] = case order[0]
                       when 'turn on'
                         true
                       when 'turn off'
                         false
                       when 'toggle'
                         !lights[[i, j]]
                       end
    end
  end
end

p lights.values.count { _1 }


lights = {}
1000.times do |i|
  1000.times do |j|
    lights[[i, j]] = 0
  end
end

input.each do |order|
  (order[1][0]..order[2][0]).each do |i|
    (order[1][1]..order[2][1]).each do |j|
      lights[[i, j]] = case order[0]
                       when 'turn on'
                         lights[[i, j]] + 1
                       when 'turn off'
                         [lights[[i, j]] - 1, 0].max
                       when 'toggle'
                         lights[[i, j]] + 2
                       end
    end
  end
end

p lights.values.sum

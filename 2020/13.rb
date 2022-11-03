input_file = File.read('./13.input').split

time = input_file[0].to_i
buses = input_file[1].split(',').reject { |b| b == 'x' }.map(&:to_i)

offset = 0
the_bus = 0
loop do
  buses.each do |bus|
    next unless ((time + offset) % bus).zero?

    pp offset * bus
    the_bus = bus
  end
  break if the_bus.positive?

  offset += 1
end

# input_file[1] = '17,x,13,19'
# input_file[1] = '67,7,59,61'
# input_file[1] = '67,x,7,59,61'
# input_file[1] = '67,7,x,59,61'
# input_file[1] = '1789,37,47,1889'
buses_with_index = input_file[1]
                   .split(',')
                   .each_with_index
                   .map { |x, i| [x, i] }
                   .reject { |b| b[0] == 'x' }
                   .map { |b| [b[0].to_i, b[1]] }

def lcm(buses)
  time = 0
  step = buses[0][0]
  matched = 1
  while matched < buses.size
    time += step
    if buses[0..matched].all? { |bus| ((time + bus[1]) % bus[0]).zero? }
      step = buses[0..matched].map { |bus| bus[0] }.reduce(1, :lcm)
      matched += 1
    end
  end

  time
end

pp lcm(buses_with_index)

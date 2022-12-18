input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

valves = {}
input.each do |line|
  parts = line.split(' ')
  valves[parts[1]] = { flow: parts[4].split('=')[1].tr(';', '').to_i, paths: parts[9..].map { _1.tr(',', '') } }
end

def calculate(valves, current, opened, time, memo)
  return memo[[current, opened, time]] if memo[[current, opened, time]]

  return 0 if time <= 0

  best = 0
  val = (time - 1) * valves[current][:flow]
  valves[current][:paths].each do |path|
    if !opened.include?(current) && val != 0
      best = [best, val + calculate(valves, path, (opened + [current]).sort, time - 2, memo)].max
    end

    best = [best, calculate(valves, path, opened, time - 1, memo)].max
  end

  memo[[current, opened, time]] = best
end

p calculate(valves, 'AA', [], 30, {})

def calculate2(valves, current, opened, time, memo)
  return memo[[current, opened, time]] if memo[[current, opened, time]]

  return memo[[opened]] ||= calculate(valves, 'AA', opened, 26, {}) if time <= 0

  best = 0
  val = (time - 1) * valves[current][:flow]
  valves[current][:paths].each do |path|
    if !opened.include?(current) && val != 0
      best = [best, val + calculate2(valves, path, (opened + [current]).sort, time - 2, memo)].max
    end

    best = [best, calculate2(valves, path, opened, time - 1, memo)].max
  end

  memo[[current, opened, time]] = best
end

p calculate2(valves, 'AA', [], 26, {})

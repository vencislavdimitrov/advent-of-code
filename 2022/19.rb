input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
blueprints = input.split("\n").map do |line|
  {
    geode: {
      ore: line.scan(/Each geode robot costs (\d+) ore and (\d+) obsidian/).first[0].to_i,
      clay: 0,
      obsidian: line.scan(/Each geode robot costs (\d+) ore and (\d+) obsidian/).first[1].to_i,
      geode: 0
    },
    obsidian: {
      ore: line.scan(/Each obsidian robot costs (\d+) ore and (\d+) clay/).first[0].to_i,
      clay: line.scan(/Each obsidian robot costs (\d+) ore and (\d+) clay/).first[1].to_i,
      obsidian: 0,
      geode: 0
    },
    clay: {
      ore: line.scan(/Each clay robot costs (\d+) ore/).first[0].to_i,
      clay: 0,
      obsidian: 0,
      geode: 0
    },
    ore: {
      ore: line.scan(/Each ore robot costs (\d+) ore/).first[0].to_i,
      clay: 0,
      obsidian: 0,
      geode: 0
    }
  }
end

def num_geodes(blueprint, resources, robots, time, memo)
  return memo[[resources, robots, time]] if memo[[resources, robots, time]]

  return resources[:geode] if time <= 0

  best =
    if resources[:ore] < blueprint.values.map { _1[:ore] }.max
      new_resources = {}
      resources.each do |k, v|
        new_resources[k] = v + robots[k]
      end
      num_geodes(blueprint, new_resources, robots, time - 1, memo)
    else
      0
    end
  blueprint.each do |new_robot, required_resources|
    next unless required_resources.all? { |k, v| resources[k] >= v }

    new_resources = {}
    resources.each do |k, v|
      new_resources[k] = v + robots[k] - required_resources[k]
    end
    new_robots = robots.clone
    new_robots[new_robot] += 1
    best = [best, num_geodes(blueprint, new_resources, new_robots, time - 1, memo)].max
  end

  memo[[resources, robots, time]] = best
end

sums = {}
(0...blueprints.size).each do |i|
  next if sums[i]

  geodes = num_geodes(
    blueprints[i],
    { geode: 0, obsidian: 0, clay: 0, ore: 0 },
    { geode: 0, obsidian: 0, clay: 0, ore: 1 },
    24,
    {}
  )
  sums[i] = geodes
end
p sums.map { (_1 + 1) * _2 }.sum

res = 1
3.times do |i|
  geodes = num_geodes(
    blueprints[i],
    { geode: 0, obsidian: 0, clay: 0, ore: 0 },
    { geode: 0, obsidian: 0, clay: 0, ore: 1 },
    32,
    {}
  )
  res *= geodes
end
p res

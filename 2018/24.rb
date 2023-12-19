input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n").map { _1.split("\n")[1..] }
immune_input, infection_input = input

def parse_input(line)
  line = line.scan(/(\d+) units each with (\d+) hit points (\(.*\) )*with an attack that does (\d+) (\w+) damage at initiative (\d+)/)[0]
  bonus_immune = line[2]&.scan(/immune to ([^;)]+)/)&.[](0)&.[](0)&.split(', ')
  bonus_weak = line[2]&.scan(/weak to ([^;)]+)/)&.[](0)&.[](0)&.split(', ')
  {
    units: line[0].to_i,
    hp: line[1].to_i,
    bonus_immune:,
    bonus_weak:,
    attack: line[3].to_i,
    attack_kind: line[4],
    initiative: line[5].to_i
  }
end
immune = immune_input.map { parse_input(_1) }.map.with_index { [_2, _1] }.to_h
infection = infection_input.map { parse_input(_1) }.map.with_index { [_2, _1] }.to_h

def effective_power(group)
  group[:units] * group[:attack]
end

def damage(group1, group2)
  return 0 if group2[:bonus_immune]&.include?(group1[:attack_kind])
  return 2 * effective_power(group1) if group2[:bonus_weak]&.include?(group1[:attack_kind])

  effective_power(group1)
end

def target_selection(army1, army2, attack_army)
  plan = []
  selected = {}
  army1.reject { _2[:units] == 0 }.sort_by { [-effective_power(_2), -_2[:initiative]] }.each do |ind, group1|
    target = army2.reject { _2[:units] == 0 || selected[_1] }
                  .max_by { [damage(group1, _2), effective_power(_2), _2[:initiative]] }
    next unless target

    damage = damage(group1, target[1])
    next unless damage > 0

    selected[target[0]] = true
    plan << [ind, target[0], attack_army]
  end
  plan
end

def combat(immune, infection)
  loop do
    break if immune.values.reject { _1[:units] == 0 }.empty? || infection.values.reject { _1[:units] == 0 }.empty?

    plan = target_selection(immune, infection, :immune) + target_selection(infection, immune, :infection)

    total_units_killed = 0
    plan.sort_by do
      _1[2] == :immune ? immune[_1[0]][:initiative] : infection[_1[0]][:initiative]
    end.reverse_each do |group1, group2, attack_army|
      if attack_army == :immune
        damage = damage(immune[group1], infection[group2])
        total_units_killed += [damage / infection[group2][:hp], infection[group2][:units]].min
        infection[group2][:units] -= [damage / infection[group2][:hp], infection[group2][:units]].min
      else
        damage = damage(infection[group1], immune[group2])
        total_units_killed += [damage / immune[group2][:hp], immune[group2][:units]].min
        immune[group2][:units] -= [damage / immune[group2][:hp], immune[group2][:units]].min
      end
    end
    return [0, false] if total_units_killed == 0
  end

  immune_win = infection.values.reject { _1[:units] == 0 }.empty?
  [immune.values.map { _1[:units] }.sum + infection.values.map { _1[:units] }.sum, immune_win]
end

p combat(immune, infection)[0]

boost = 1
step = 50
loop do
  immune = immune_input.map { parse_input(_1) }.map.with_index { [_2, _1] }.to_h
  immune.each_key do |k|
    immune[k][:attack] += boost
  end
  infection = infection_input.map { parse_input(_1) }.map.with_index { [_2, _1] }.to_h

  res = combat(immune, infection)
  if res[1]
    if step == 1
      p res[0]
      break
    else
      step /= 2
      boost -= step
    end
  else
    boost += step
  end
end

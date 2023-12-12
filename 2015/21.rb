input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

boss = input.map { _1.split(': ')[-1].to_i }

weapons, armors, rings = '
Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0

Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5

Rings:      Cost  Damage  Armor
Damage_+1    25     1       0
Damage_+2    50     2       0
Damage_+3   100     3       0
Defense_+1   20     0       1
Defense_+2   40     0       2
Defense_+3   80     0       3'.strip.split("\n\n").map { _1.split("\n")[1..].map { |x| x.split[1..].map(&:to_i) } }

def play(player, boss)
  return true if boss[0] <= 0
  return false if player[0] <= 0

  loop do
    boss[0] -= [player[1] - boss[2], 1].max
    return true if boss[0] <= 0

    player[0] -= [boss[1] - player[2], 1].max
    return false if player[0] <= 0
  end
end

min_gold = 1000
max_gold = 0
weapons.each do |weapon|
  armors.each do |armor|
    (0...rings.size - 1).each do |i|
      (i + 1...rings.size).each do |j|
        (1..4).each do |items_count|
          [armor, rings[i], rings[j]].combination(items_count).each do |items|
            items << weapon
            damage = items.sum { _1[1] }
            defence = items.sum { _1[2] }

            if play([100, damage, defence], boss.clone)
              min_gold = [min_gold, items.sum { _1[0] }].min
            else
              p [items] if items.sum { _1[0] } == 233
              max_gold = [max_gold, items.sum { _1[0] }].max
            end
          end
        end
      end
    end
  end
end
p min_gold
p max_gold

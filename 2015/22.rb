input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

boss = input.map { _1.split(': ')[-1].to_i }
boss = { 'hp' => boss[0], 'damage' => boss[1] }

player = { 'hp' => 50, 'mana' => 500 }
spells = {
  'Magic Missile' => { 'cost' => 53, 'duration' => 1, 'damage' => 4 },
  'Drain' => { 'cost' => 73, 'duration' => 1, 'damage' => 2, 'heal' => 2 },
  'Shield' => { 'cost' => 113, 'duration' => 6, 'armor' => 7 },
  'Poison' => { 'cost' => 173, 'damage' => 3, 'duration' => 6 },
  'Recharge' => { 'cost' => 229, 'mana' => 101, 'duration' => 5 }
}
def apply_effect(boss, player, effects, mana_spent, mana)
  player['armor'] = 0
  effects.each do |_, effect|
    boss['hp'] -= effect['damage'] if effect.key?('damage')
    player['hp'] += effect['heal'] if effect.key?('heal')
    player['armor'] += effect['armor'] if effect.key?('armor')
    player['mana'] += effect['mana'] if effect.key?('mana')
    effect['duration'] -= 1
  end
  effects.delete_if { |_, duration| duration['duration'] <= 0 }

  return [mana_spent, true] if mana_spent <= mana && boss['hp'] <= 0

  [mana, boss['hp'] <= 0]
end

def play(boss, player, spells, part2, effects = {}, mana_spent = 0, mana = 999_999)
  player['hp'] -= 1 if part2
  mana, game_ended = apply_effect(boss, player, effects, mana_spent, mana)
  spells.each do |spell_name, spell|
    unless spell['cost'] <= player['mana'] && spell['cost'] + mana_spent < mana && !effects.key?(spell_name)
      next
    end

    this_player = player.clone
    this_boss = boss.clone
    this_effects = { spell_name => spell.clone }

    effects.each { |name, effect| this_effects[name] = effect.clone }
    this_player['mana'] -= spell['cost']
    mana, game_ended = apply_effect(this_boss, this_player, this_effects, mana_spent + spell['cost'], mana)
    this_player['hp'] -= if this_boss['damage'] > this_player['armor']
                           this_boss['damage'] - this_player['armor']
                         else
                           1
                         end
    game_ended ||= this_player['hp'] <= (part2 ? 1 : 0)
    mana = play(this_boss, this_player, spells, part2, this_effects, mana_spent + spell['cost'], mana) unless game_ended
  end
  mana
end

p play(boss.clone, player.clone, spells, false)
p play(boss, player, spells, true)

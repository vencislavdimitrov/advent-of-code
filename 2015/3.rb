input = File.read(File.basename(__FILE__).gsub('rb', 'input'))

coordinates = [0, 0]
houses = {}
houses[coordinates.to_s] = 1

input.chars.each do |dir|
  case dir
  when '>'
    coordinates[0] += 1
  when '<'
    coordinates[0] -= 1
  when '^'
    coordinates[1] -= 1
  when 'v'
    coordinates[1] += 1
  end
  houses[coordinates.to_s] = 1
end
p houses.count

houses = {}
santa = [0, 0]
robo_santa = [0, 0]
houses[santa.to_s] = 1
input.chars.each_with_index do |dir, i|
  case dir
  when '>'
    i.odd? ? santa[0] += 1 : robo_santa[0] += 1
  when '<'
    i.odd? ? santa[0] -= 1 : robo_santa[0] -= 1
  when '^'
    i.odd? ? santa[1] -= 1 : robo_santa[1] -= 1
  when 'v'
    i.odd? ? santa[1] += 1 : robo_santa[1] += 1
  end
  houses[i.odd? ? santa.to_s : robo_santa.to_s] = 1
end

p houses.count

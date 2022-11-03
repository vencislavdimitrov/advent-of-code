input_file = File.read('./6.input').split("\n\n").map(&:split)

total = 0
input_file.each do |group|
  group_all = []
  group.each do |person|
    group_all += person.chars
  end
  total += group_all.uniq.count
end

pp total

total = 0
input_file.each do |group|
  group_all = group[0].chars
  group.each do |person|
    group_all &= person.chars
  end
  total += group_all.uniq.count
end

pp total

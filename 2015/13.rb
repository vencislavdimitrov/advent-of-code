input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip
input = input.split("\n")

input = input.map { _1.split(' ') }.map { [_1[0], _1[3].to_i * (_1[2] == 'lose' ? -1 : 1), _1[-1][0..-2]] }

people = {}
input.each do |line|
  people[line[0]] ||= {}
  people[line[0]][line[2]] = line[1]
end

def happiness(order, people)
  sum = 0
  order.each_cons(2) do |a, b|
    sum += people[a][b]
    sum += people[b][a]
  end
  sum += people[order[-1]][order[0]]
  sum += people[order[0]][order[-1]]
  sum
end

p people.keys.permutation.to_a.map { happiness(_1, people) }.max

people.each_key do |person|
  people['me'] ||= {}
  people['me'][person] = 0
  people[person]['me'] = 0
end
p people.keys.permutation.to_a.map { happiness(_1, people) }.max

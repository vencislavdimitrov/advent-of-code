input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

sue = "children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1".split("\n").map { _1.split(': ') }.map { [_1[0], _1[1].to_i] }.to_h

input = input.map { _1.split(': ')[1..].join(' ').split(', ').map { |s| s.split(' ') }.map { |k, v| [k, v.to_i] }.to_h }

(1...input.size).each do |i|
  score = input[i].map { |k, _| (input[i][k] - sue[k]).abs }.sum

  p i + 1 if score == 0
end

(1...input.size).each do |i|
  score = input[i].map do |k, _|
    if ['cats', 'trees'].include?(k)
      input[i][k] > sue[k] ? 0 : 999
    elsif ['pomeranians', 'goldfish'].include?(k)
      input[i][k] < sue[k] ? 0 : 999
    else
      (input[i][k] - sue[k]).abs
    end
  end.sum

  p i + 1 if score == 0
end

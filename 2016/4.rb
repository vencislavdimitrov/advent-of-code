input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

input = input.map { _1.split('[') }.map { [_1[1][...-1], _1[0].rpartition('-')[0], _1[0].rpartition('-')[-1].to_i]}

p input.select { _1[1].tr('-', '').chars.tally.sort_by { |v, k| [-k, v]}.map(&:first)[...5].join == _1[0] }.sum { _1[2] }

sector = input.map do |room|
  [room[1].chars.map{ |c| ((c.ord - 'a'.ord + room[2]%26) % 26 + 'a'.ord).chr }.join, room[2]]
end.select { _1[0].index('northpole') }[0][1]
p sector

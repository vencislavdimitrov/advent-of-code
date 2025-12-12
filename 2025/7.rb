input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

beams = [[input[0].index('S')]]

splits = 0
(1...input.size).each do |i|
  splits += beams.last.map { input[i][_1] }.count('^')
  beams << beams.last.map { input[i][_1] == '.' ? _1 : [_1 - 1, _1 + 1]}.flatten.uniq
end
p splits

$memo = {}
def count_beams(i, j, beams, input)
  return 1 if i == input.size - 1

  return $memo[[i, j]] if $memo[[i, j]]

  $memo[[i, j]] = beams[i+1].filter { ((_1 - j).abs == 1 && input[i+1][j] == '^') || ((_1 - j).abs == 0 && input[i+1][j] == '.') }.sum do |jj|
    count_beams(i+1, jj, beams, input)
  end

  $memo[[i, j]]
end
p count_beams(0, input[0].index('S'), beams, input)

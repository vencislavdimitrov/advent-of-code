codes = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")

$positions = {
  '7' => [0, 0],
  '8' => [0, 1],
  '9' => [0, 2],
  '4' => [1, 0],
  '5' => [1, 1],
  '6' => [1, 2],
  '1' => [2, 0],
  '2' => [2, 1],
  '3' => [2, 2],
  '0' => [3, 1],
  'A' => [3, 2],
  '^' => [0, 1],
  'a' => [0, 2],
  '<' => [1, 0],
  'v' => [1, 1],
  '>' => [1, 2]
}
$directions = {
  '^' => [-1, 0],
  'v' => [1, 0],
  '<' => [0, -1],
  '>' => [0, 1]
}

def paths(start, finish, num)
  delta = [finish[0] - start[0], finish[1] - start[1]]
  path = ''
  if delta[0] < 0
    path += '^' * delta[0].abs
  else
    path += 'v' * delta[0]
  end
  if delta[1] < 0
    path += '<' * delta[1].abs
  else
    path += '>' * delta[1]
  end
  paths = path.chars.permutation.to_a.uniq
    .filter { |s|
      !s.map {$directions[_1]}
        .reduce([start]) { _1 + [[_1.last[0] + _2[0], _1.last[1] + _2[1]]] }
        .any? { _1 == (num ? [3, 0] : [0, 0]) }
    }.map { _1.join + 'a' }
  paths = ['a'] if paths == []
  paths
end

$memo = {}
def min_length(code, iter, depth=0)
  return $memo[[code, depth, iter]] if $memo[[code, depth, iter]]

  pos = depth == 0 ? [3, 2] : [0, 2]
  length = 0
  code.chars.each do |char|
    next_pos = $positions[char]
    paths = paths(pos, next_pos, depth == 0)
    if depth == iter
      length += (paths[0] || 'a').size
    else
      length += paths.map { min_length(_1, iter, depth + 1) }.min
    end
    pos = next_pos
  end
  $memo[[code, depth, iter]] = length
end

p codes.sum { min_length(_1, 2) * _1[..-1].to_i }
p codes.sum { min_length(_1, 25) * _1[..-1].to_i }


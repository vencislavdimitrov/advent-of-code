input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

dirs = {
  'L' => [0, -1],
  'R' => [0, 1],
  'U' => [-1, 0],
  'D' => [1, 0]
}

dial = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]
pos = [1, 1]
code = input.map do
  _1.chars.each do |c|
    pos[0] = [[pos[0] + dirs[c][0], 2].min, 0].max
    pos[1] = [[pos[1] + dirs[c][1], 2].min, 0].max
  end
  dial[pos[0]][pos[1]]
end.join
puts code

dial = [
  [nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, 1, nil, nil, nil],
  [nil, nil, 2, 3, 4, nil, nil],
  [nil, 5, 6, 7, 8, 9, nil],
  [nil, nil, 'A', 'B', 'C', nil, nil],
  [nil, nil, nil, 'D', nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil]
]
pos = [3, 1]
code = input.map do
  _1.chars.each do |c|
    if dial[pos[0] + dirs[c][0]][pos[1] + dirs[c][1]]
      pos[0] = pos[0] + dirs[c][0]
      pos[1] = pos[1] + dirs[c][1]
    end
  end
  dial[pos[0]][pos[1]]
end.join
puts code

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip[1...-1]

dir = {
  'N' => [0, -1],
  'E' => [1, 0],
  'S' => [0, 1],
  'W' => [-1, 0]
}

stack = []
x = 0
y = 0
prev_x = x
prev_y = y
distances = {}
distances[[prev_x, prev_y].to_s] = 0
input.chars.each do |c|
  case c
  when '('
    stack << [x, y]
  when ')'
    x, y = stack.pop
  when '|'
    x, y = stack[-1]
  else
    x += dir[c][0]
    y += dir[c][1]
    distances[[x, y].to_s] ||= 0
    distances[[x, y].to_s] = if distances[[x, y].to_s] != 0
                               [distances[[x, y].to_s], distances[[prev_x, prev_y].to_s] + 1].min
                             else
                               distances[[prev_x, prev_y].to_s] + 1
                             end
  end
  prev_x = x
  prev_y = y
end
p distances.values.max
p distances.values.count { _1 >= 1000 }

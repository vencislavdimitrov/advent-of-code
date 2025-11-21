input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.chars }

start = [0, input[0].index('|')]

direction = [1, 0]
answer = ''
steps = 0
loop do
  if input[start[0]][start[1]].match(/[A-Z]/)
    answer += input[start[0]][start[1]]
  elsif input[start[0]][start[1]] == ' '
    break
  elsif input[start[0]][start[1]] == '+'
    case direction
    when [1, 0]
      if start[1] + 1 < input[start[0]].size && input[start[0]][start[1] + 1] != ' '
        direction = [0, 1]
      else
        direction = [0, -1]
      end
    when [-1, 0]
      if start[1] + 1 < input[start[0]].size && input[start[0]][start[1] + 1] != ' '
        direction = [0, 1]
      else
        direction = [0, -1]
      end
    when [0, 1]
      if start[0] + 1 < input.size && !input[start[0] + 1][start[1]].nil? && input[start[0] + 1][start[1]] != ' '
        direction = [1, 0]
      else
        direction = [-1, 0]
      end
    when [0, -1]
      if start[0] + 1 < input.size && !input[start[0] + 1][start[1]].nil? && input[start[0] + 1][start[1]] != ' '
        direction = [1, 0]
      else
        direction = [-1, 0]
      end
    end
  end
  start = [start[0] + direction[0], start[1] + direction[1]]
  steps += 1
end

puts answer
puts steps

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

start = [input.index { _1.index('S') }, input.find { _1.index('S') }.index('S')]

loop_length = 1
current_pos = [start[0] + 1, start[1]] # manually choose starting direction
previous_pos = [-1, 0]
steps = { start.to_s => 1 }
while input[current_pos[0]][current_pos[1]] != 'S'
  steps[current_pos.to_s] = steps.values.max + 1
  case input[current_pos[0]][current_pos[1]]
  when '|'
    if previous_pos == [1, 0]
      current_pos[0] -= 1
    elsif previous_pos == [-1, 0]
      current_pos[0] += 1
    else
      break
    end
  when '-'
    if previous_pos == [0, 1]
      current_pos[1] -= 1
    elsif previous_pos == [0, -1]
      current_pos[1] += 1
    end
  when 'L'
    if previous_pos == [-1, 0]
      previous_pos = [0, -1]
      current_pos[1] += 1
    elsif previous_pos == [0, 1]
      previous_pos = [1, 0]
      current_pos[0] -= 1
    else
      break
    end
  when 'J'
    if previous_pos == [-1, 0]
      previous_pos = [0, 1]
      current_pos[1] -= 1
    elsif previous_pos == [0, -1]
      previous_pos = [1, 0]
      current_pos[0] -= 1
    else
      break
    end
  when '7'
    if previous_pos == [1, 0]
      previous_pos = [0, 1]
      current_pos[1] -= 1
    elsif previous_pos == [0, -1]
      previous_pos = [-1, 0]
      current_pos[0] += 1
    end
  when 'F'
    if previous_pos == [1, 0]
      previous_pos = [0, -1]
      current_pos[1] += 1
    elsif previous_pos == [0, 1]
      previous_pos = [-1, 0]
      current_pos[0] += 1
    else
      break
    end
  else
    break
  end
  loop_length += 1
end
p loop_length / 2

enclosed = 0
(0...input.size).each do |i|
  intersects = 0
  (0...input[i].size).each do |j|
    if steps[[i, j].to_s]
      if steps[[i + 1, j].to_s] && steps[[i + 1, j].to_s] - steps[[i, j].to_s] == 1
        intersects += 1
      elsif steps[[i + 1, j].to_s] && steps[[i + 1, j].to_s] - steps[[i, j].to_s] == -1
        intersects -= 1
      end
    elsif intersects == 1
      enclosed += 1
    end
  end
end
p enclosed

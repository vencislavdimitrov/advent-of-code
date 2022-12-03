input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

score = 0
input.each do |line|
  opponent, res = line.split
  case opponent
  when 'A'
    case res
    when 'X'
      score += 4
    when 'Y'
      score += 8
    when 'Z'
      score += 3
    end
  when 'B'
    case res
    when 'X'
      score += 1
    when 'Y'
      score += 5
    when 'Z'
      score += 9
    end
  when 'C'
    case res
    when 'X'
      score += 7
    when 'Y'
      score += 2
    when 'Z'
      score += 6
    end
  end
end
p score


score = 0
input.each do |line|
  opponent, res = line.split
  case opponent
  when 'A'
    case res
    when 'X'
      score += 3
    when 'Y'
      score += 4
    when 'Z'
      score += 8
    end
  when 'B'
    case res
    when 'X'
      score += 1
    when 'Y'
      score += 5
    when 'Z'
      score += 9
    end
  when 'C'
    case res
    when 'X'
      score += 2
    when 'Y'
      score += 6
    when 'Z'
      score += 7
    end
  end
end
p score

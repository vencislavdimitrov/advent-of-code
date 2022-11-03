input_file = File.read('./12.input').split

current_pos = [0, 0]
direction = :east
directions = [:east, :north, :west, :south]

input_file.each do |ins|
  case ins[0]
  when 'N'
    current_pos[1] += ins[1..].to_i
  when 'S'
    current_pos[1] -= ins[1..].to_i
  when 'E'
    current_pos[0] += ins[1..].to_i
  when 'W'
    current_pos[0] -= ins[1..].to_i
  when 'R'
    direction = directions[(directions.find_index(direction) - ins[1..].to_i / 90) % 4]
  when 'L'
    direction = directions[(directions.find_index(direction) + ins[1..].to_i / 90) % 4]
  when 'F'
    case direction
    when :east
      current_pos[0] += ins[1..].to_i
    when :west
      current_pos[0] -= ins[1..].to_i
    when :north
      current_pos[1] += ins[1..].to_i
    when :south
      current_pos[1] -= ins[1..].to_i
    end
  end
end

pp current_pos[0].abs + current_pos[1].abs

current_pos = [0, 0]
way_point = [10, 1]

input_file.each do |ins|
  case ins[0]
  when 'N'
    way_point[1] += ins[1..].to_i
  when 'S'
    way_point[1] -= ins[1..].to_i
  when 'E'
    way_point[0] += ins[1..].to_i
  when 'W'
    way_point[0] -= ins[1..].to_i
  when 'R'
    case ins[1..].to_i / 90
    when 1
      way_point = [way_point[1], - way_point[0]]
    when 2
      way_point = [- way_point[0], - way_point[1]]
    when 3
      way_point = [- way_point[1], way_point[0]]
    end
  when 'L'
    case ins[1..].to_i / 90
    when 1
      way_point = [- way_point[1], way_point[0]]
    when 2
      way_point = [- way_point[0], - way_point[1]]
    when 3
      way_point = [way_point[1], - way_point[0]]
    end
  when 'F'
    current_pos[0] += way_point[0] * ins[1..].to_i
    current_pos[1] += way_point[1] * ins[1..].to_i
  end
end

pp current_pos[0].abs + current_pos[1].abs

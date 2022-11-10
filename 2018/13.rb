input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.lines

directions = ['^', '>', 'v', '<']
carts = []
(0...input.size).each do |i|
  (0...input[i].size).each do |j|
    carts << { x: i, y: j, turns: 0, direction: input[i][j], crashed: false } if directions.include?(input[i][j])
    input[i][j] = '|' if ['^', 'v'].include?(input[i][j])
    input[i][j] = '-' if ['>', '<'].include?(input[i][j])
  end
end

loop do
  if carts.reject { _1[:crashed] }.size <= 1
    puts "#{carts.reject { _1[:crashed] }[0][:y]},#{carts.reject { _1[:crashed] }[0][:x]}"
    break
  end
  carts.sort_by! { _1[:x] * 100 + _1[:y] }
  carts.each do |cart|
    next if cart[:crashed]

    new_pos =
      case cart[:direction]
      when '^'
        [cart[:x] - 1, cart[:y]]
      when 'v'
        [cart[:x] + 1, cart[:y]]
      when '<'
        [cart[:x], cart[:y] - 1]
      when '>'
        [cart[:x], cart[:y] + 1]
      end

    crashes = carts.select { _1[:x] == new_pos[0] && _1[:y] == new_pos[1] && !_1[:crashed] }
    if crashes.any?
      puts "#{new_pos[1]},#{new_pos[0]}"
      cart[:crashed] = true
      crashes.each { _1[:crashed] = true }
    end

    new_direction =
      case input[new_pos[0]][new_pos[1]]
      when '/'
        case cart[:direction]
        when '^'
          '>'
        when 'v'
          '<'
        when '<'
          'v'
        else
          '^'
        end
      when '\\'
        case cart[:direction]
        when '^'
          '<'
        when 'v'
          '>'
        when '<'
          '^'
        else
          'v'
        end
      when '+'
        cart[:turns] += 1
        case (cart[:turns] - 1) % 3
        when 0
          directions[directions.find_index(cart[:direction]) - 1]
        when 1
          cart[:direction]
        when 2
          directions[(directions.find_index(cart[:direction]) + 1) % directions.size]
        end
      else
        cart[:direction]
      end

    cart[:x] = new_pos[0]
    cart[:y] = new_pos[1]
    cart[:direction] = new_direction
  end
end

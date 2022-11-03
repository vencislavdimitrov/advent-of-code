input = File.read('./3.input').split("\n")

claims = input.map { _1.split('@ ')[1] }.map { _1.split(': ') }

fabric = Array.new(1000)
1000.times do |i|
  fabric[i] = ' ' * 1000
end
claims.each do |claim|
  offset = claim[0].split(',').map(&:to_i)
  size = claim[1].split('x').map(&:to_i)
  size[0].times do |w|
    size[1].times do |h|
      case fabric[offset[1] + h][offset[0] + w]
      when '.'
        fabric[offset[1] + h][offset[0] + w] = 'X'
      when ' '
        fabric[offset[1] + h][offset[0] + w] = '.'
      end
    end
  end
end
p fabric.join.count 'X'

claims.each_with_index do |claim, id|
  offset = claim[0].split(',').map(&:to_i)
  size = claim[1].split('x').map(&:to_i)
  overlap = false
  size[0].times do |w|
    size[1].times do |h|
      if fabric[offset[1] + h][offset[0] + w] == 'X'
        overlap = true
        break
      end
    end
    break if overlap
  end
  unless overlap
    p id + 1
    break
  end
end

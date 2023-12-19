input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

clay = {}

input.each do |line|
  a, b = line.split(', ')

  if a[0] == 'x'
    x = a.split('=')[1].to_i
    b1, b2 = b.split('=')[1].split('..').map(&:to_i)
    (b1..b2).each do |y|
      clay[[x, y]] = true
    end
  else
    y = a.split('=')[1].to_i
    b1, b2 = b.split('=')[1].split('..').map(&:to_i)
    (b1..b2).each do |x|
      clay[[x, y]] = true
    end
  end
end

y_min = clay.keys.min_by { _1[1] }[1]
y_max = clay.keys.max_by { _1[1] }[1]

def fill(point, dir, memo)
  memo[:flowing][point] = true
  bellow = [point[0], point[1] + 1]

  if !memo[:clay][bellow] && !memo[:flowing][bellow] && bellow[1] >= 1 && bellow[1] <= memo[:y_max]
    fill(bellow, [0, 1], memo)
  end

  return false if !memo[:clay][bellow] && !memo[:settled][bellow]

  left = [point[0] - 1, point[1]]
  right = [point[0] + 1, point[1]]

  left_filled = memo[:clay][left] || !memo[:flowing][left] && fill(left, [-1, 0], memo)
  right_filled = memo[:clay][right] || !memo[:flowing][right] && fill(right, [1, 0], memo)

  if dir == [0, 1] && left_filled && right_filled
    memo[:settled][point] = true

    while memo[:flowing][left]
      memo[:settled][left] = true
      left = [left[0] - 1, left[1]]
    end

    while memo[:flowing][right]
      memo[:settled][right] = true
      right = [right[0] + 1, right[1]]
    end
  end

  dir == [-1, 0] && (left_filled || memo[:clay][left]) || dir == [1, 0] && (right_filled || memo[:clay][right])
end

flowing = {}
settled = {}

fill([500, 0], [0, 1], { y_min:, y_max:, clay:, flowing:, settled: })

p (flowing.keys | settled.keys).select { _1[1] >= y_min && _1[1] <= y_max }.count
p settled.keys.select { _1[1] >= y_min && _1[1] <= y_max }.count

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(' => ') }

pattern = '.#./..#/###'

def rotate_and_flip(pattern)
  rotated = pattern.split('/').map(&:chars)

  result = []
  4.times do
    rotated = rotated.transpose.map(&:reverse)
    result << rotated.map(&:join).join('/')
    result << rotated.reverse.map(&:join).join('/')
    result << rotated.map(&:reverse).map(&:join).join('/')
  end

  result
end

rules = {}
input.each do |rule|
  rotate_and_flip(rule[0]).each do |rotated_rule|
    rules[rotated_rule] = rule[1]
  end
end

18.times do |iterations|
  p pattern.count('#') if iterations == 5
  pattern = pattern.split('/').map(&:chars)
  if pattern[0].size % 2 == 0
    patterns = []
    squares = pattern[0].size / 2
    squares.times do |i|
      squares.times do |j|
        patterns << [
          [pattern[i*2][j*2], pattern[i*2][j*2+1]],
          [pattern[i*2+1][j*2], pattern[i*2+1][j*2+1]],
        ]
      end
    end
    patterns = patterns.map { _1.map(&:join).join('/') }.map { rules[_1] }
    patterns = patterns.map { _1.split('/').map(&:chars) }
    pattern = []
    squares.times do |i|
      line = Array.new(3) { [] }
      squares.times do |j|
        line = line.zip(patterns[i * squares + j]).map(&:flatten)
      end
      pattern += line
    end

    pattern = pattern.map(&:join).join('/')
  else
    patterns = []
    squares = pattern[0].size / 3
    squares.times do |i|
      squares.times do |j|
        patterns << [
          [pattern[i*3][j*3], pattern[i*3][j*3+1], pattern[i*3][j*3+2]],
          [pattern[i*3+1][j*3], pattern[i*3+1][j*3+1], pattern[i*3+1][j*3+2]],
          [pattern[i*3+2][j*3], pattern[i*3+2][j*3+1], pattern[i*3+2][j*3+2]],
        ]
      end
    end
    patterns = patterns.map { _1.map(&:join).join('/') }.map { rules[_1] }
    patterns = patterns.map { _1.split('/').map(&:chars) }
    pattern = []
    squares.times do |i|
      line = Array.new(4) { [] }
      squares.times do |j|
        line = line.zip(patterns[i * squares + j]).map(&:flatten)
      end
      pattern += line
    end

    pattern = pattern.map(&:join).join('/')
  end
end

p pattern.count('#')


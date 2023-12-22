input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")
input = input.map { _1.split('~').map { |b| b.split(',').map(&:to_i) } }

bricks = []
input.each do |b|
  bricks << []
  (b[0][0]..b[1][0]).each do |x|
    (b[0][1]..b[1][1]).each do |y|
      (b[0][2]..b[1][2]).each do |z|
        bricks[-1] << [x, y, z]
      end
    end
  end
end

bricks = bricks.sort_by { _1.map { |b| b[2] }.min }
def fall(bricks)
  fallen = []
  max_z = Hash.new { 0 }
  (0...bricks.size).each do |i|
    diff = bricks[i].map { _1[2] }.min - bricks[i].map { |b| max_z[[b[0], b[1]]] }.max - 1
    moved_brick = bricks[i].map { [_1[0], _1[1], _1[2] - diff] }

    fallen << moved_brick
    bricks[i].each do |b|
      max_z[[b[0], b[1]]] = [max_z[[b[0], b[1]]], moved_brick.map { _1[2] }.max].max
    end
  end
  fallen
end

def count_fallen(bricks)
  max_z = Hash.new { 0 }
  moved = 0
  (0...bricks.size).each do |i|
    diff = bricks[i].map { _1[2] }.min - bricks[i].map { |b| max_z[[b[0], b[1]]] }.max - 1
    moved_brick = bricks[i].map { [_1[0], _1[1], _1[2] - diff] }

    moved += 1 if diff > 0

    bricks[i].each do |b|
      max_z[[b[0], b[1]]] = [max_z[[b[0], b[1]]], moved_brick.map { _1[2] }.max].max
    end
  end
  moved
end

bricks = fall(bricks)

p (0...bricks.size).count { count_fallen(bricks[0..._1] + bricks[_1 + 1..]) == 0 }
p (0...bricks.size).sum { count_fallen(bricks[0..._1] + bricks[_1 + 1..]) }

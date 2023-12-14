input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

def tilt(platform)
  (0...platform.size).each do |i|
    (0...platform[i].size).each do |j|
      next unless platform[i][j] == 'O'

      k = i - 1
      loop do
        break if k == -1 || platform[k][j] == '#' || platform[k][j] == 'O'

        k -= 1
      end
      platform[i][j], platform[k + 1][j] = platform[k + 1][j], platform[i][j]
    end
  end
  platform
end

def load(platform)
  platform.reverse.map.with_index { (_2 + 1) * _1.count('O') }.sum
end

p load(tilt(input.map(&:clone)))

@cache = {}
platform = input.map(&:clone)
t = 0
while t < 1_000_000_000
  if @cache[platform.map(&:join).join]
    t = 1_000_000_000 - ((1_000_000_000 - t) % (t - @cache[platform.map(&:join).join]))
  end
  @cache[platform.map(&:join).join] = t
  t += 1

  platform = tilt(platform).transpose.map(&:reverse)
  platform = tilt(platform).transpose.map(&:reverse)
  platform = tilt(platform).transpose.map(&:reverse)
  platform = tilt(platform).transpose.map(&:reverse)
end
p load(platform)

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")

input = input.map { _1.split("\n") }

def refrection(pattern, smudge)
  (0...pattern.size - 1).each do |i|
    diff = 0
    (0...pattern.size).each do |j|
      if i + (i - j) + 1 < pattern.size && i + (i - j) + 1 >= 0 && pattern[j] != pattern[i + (i - j) + 1]
        diff += DidYouMean::Levenshtein.distance(pattern[j], pattern[i + (i - j) + 1])
      end
    end

    return i + 1 if diff == smudge
  end
  nil
end

vertical = 0
horizontal = 0
input.each do |pattern|
  ref = refrection(pattern, 0)
  vertical += ref if ref
  pattern = pattern.map(&:chars).transpose.map(&:join)
  ref = refrection(pattern, 0)
  horizontal += ref if ref
end
p vertical * 100 + horizontal

vertical = 0
horizontal = 0
input.each do |pattern|
  ref = refrection(pattern, 2)
  vertical += ref if ref
  pattern = pattern.map(&:chars).transpose.map(&:join)
  ref = refrection(pattern, 2)
  horizontal += ref if ref
end
p vertical * 100 + horizontal

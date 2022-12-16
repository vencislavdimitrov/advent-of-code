input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

input = input.map { _1.split(' ').select { |s| s.include?('=') }.map { |s| s.tr(',:x=y=', '').to_i } }

def dist(x, y)
  (x[0] - y[0]).abs + (x[1] - y[1]).abs
end

line = 2_000_000

cover = input.select { dist(_1[..1], _1[2..]) > (line - _1[1]).abs }.map do |point|
  spread = dist(point[..1], point[2..]) - (line - point[1]).abs
  (point[0] - spread...point[0] + spread).to_a
end.flatten.uniq

p cover.count

4_000_000.times do |i|
  ranges = input.select { dist(_1[..1], _1[2..]) > (i - _1[1]).abs }.map do |point|
    spread = dist(point[..1], point[2..]) - (i - point[1]).abs
    (point[0] - spread...point[0] + spread)
  end.sort_by(&:begin)

  current = ranges.first
  merged_ranges = []
  ranges[1..].each do |range|
    if current.end < range.begin || range.end < current.begin
      merged_ranges << current
      current = range
    else
      current = [current.begin, range.begin].min..[current.end, range.end].max
    end
  end

  merged_ranges << current

  next unless merged_ranges.count == 2

  p (merged_ranges.first.end + 1) * 4_000_000 + i
  break
end

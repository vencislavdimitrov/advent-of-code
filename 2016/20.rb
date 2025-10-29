input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split('-').map(&:to_i) }.map { _1.._2 }

input.sort_by! { |interval| interval.begin }

merged = []
input.each do |interval|
  if merged.empty? || merged.last.end < interval.begin - 1
    merged << interval
  else
    merged[-1] = merged.last.begin..interval.end if interval.end > merged.last.end
  end
end
p merged[0].end + 1

allowed = (0...merged.first.begin).size
merged.each_cons(2) do |r1, r2|
  allowed += (r1.end...r2.begin).size - 1
end
allowed += (merged.last.end..4294967295).size - 1
p allowed

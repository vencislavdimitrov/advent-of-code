ranges, ingredients = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")

ranges = ranges.split("\n").map{ _1.split('-').map(&:to_i) }.map { (_1[0].._1[1]) }
ingredients = ingredients.split("\n").map(&:to_i)

p ingredients.count { |ingredient| ranges.any? { _1.include?(ingredient)} }

ranges.sort_by! { |interval| interval.begin }
merged = []
ranges.each do |interval|
  if merged.empty? || merged.last.end < interval.begin - 1
    merged << interval
  elsif interval.end > merged.last.end
    merged[-1] = merged.last.begin..interval.end
  end
end

p merged.sum { _1.size }

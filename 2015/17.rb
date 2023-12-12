input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:to_i)

total = 0
min_count = input.size
(1..input.size).each do |i|
  input.combination(i).each do |com|
    if com.sum == 150
      total += 1
      min_count = [min_count, com.count].min
    end
  end
end
p total

total = 0
input.combination(min_count).each do |com|
  total += 1 if com.sum == 150
end
p total

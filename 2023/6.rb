input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

time = input[0].split[1..].map(&:to_i)
distance = input[1].split[1..].map(&:to_i)

total = 1
(0...time.size).each do |i|
  ways = 0
  (0...time[i]).each do |t|
    ways += 1 if distance[i] < (time[i] - t) * t
  end
  total *= ways
end

p total

time = time.join.to_i
distance = distance.join.to_i
ways = 0
(0...time).each do |t|
  ways += 1 if distance < (time - t) * t
end

p ways

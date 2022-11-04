input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { [_1.split[1], _1.split[7]] }

steps = {}
input.flatten.uniq.each do |step|
  steps[step] = input.select { _1.last == step }.map(&:first)
end

done_steps = []
while done_steps.size < input.flatten.uniq.size
  done_steps << steps.reject { |k, _| done_steps.include? k }.select { |_, v| (v - done_steps).empty? }.keys.min
end

p done_steps.join


done_steps = []
workers = []
elapsed_time = 0
while done_steps.size < input.flatten.uniq.size
  done_steps += workers.select { _1.last.ord - 'A'.ord + 61 == _1.size }.map(&:last)
  workers.delete_if { _1.last.ord - 'A'.ord + 61 == _1.size }
  workers = workers.map { _1 << _1.last }
  (5 - workers.size).times do
    new_work = steps.reject { |k, _| done_steps.include?(k) }
                    .reject { |k, _| workers.map(&:last).include?(k) }
                    .select { |_, v| (v - done_steps).empty? }
                    .keys
                    .min
    workers << [new_work] unless new_work.nil?
  end
  elapsed_time += 1
end

p elapsed_time - 1

input = File.read('./4.input').split("\n").map { _1[1..].split('] ') }.sort_by { _1[0] }

guards = {}

current_guard = ''
input.each do |line|
  if line[1].start_with? 'Guard'
    current_guard = line[1].split[1]
    guards[current_guard] ||= (0...60).to_a.reduce({}) { |h, v| h.merge({ v => 0 }) }
  elsif line[1].start_with? 'falls asleep'
    minute = line[0].split(':')[1].to_i
    (minute...60).each do |i|
      guards[current_guard][i] += 1
    end
  else
    minute = line[0].split(':')[1].to_i
    (minute...60).each do |i|
      guards[current_guard][i] -= 1
    end
  end
end

chosen_guard = guards.max_by { _2.values.sum }
p chosen_guard[0].gsub('#', '').to_i * chosen_guard[1].max_by { _2 }[0]

chosen_guard = guards.max_by { _2.values.max }
p chosen_guard[0].gsub('#', '').to_i * chosen_guard[1].max_by { _2 }[0]

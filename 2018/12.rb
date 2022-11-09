input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
initial_state, notes = input.split("\n\n")
initial_state = initial_state.split.last
notes = notes.split("\n").map { _1.split(' => ') }.select { _1[1] == '#' }.to_h

state = "........#{initial_state}........................"
20.times do
  new_state = '.' * state.size
  state.chars.each_cons(5).to_a.each_with_index do |part, i|
    new_state[i + 2] = '#' unless notes[part.join].nil?
  end
  state = new_state
end
p state.chars.map.with_index { |c, i| c == '#' ? i - 8 : 0 }.sum


state = initial_state.clone
f_pad = 4
e_pad = 4
sums = []
200.times do
  if state[-5..].chars.include? '#'
    e_pad *= 2
    state = "#{state}#{'.' * e_pad}"
  end
  if state[0, 3].chars.include? '#'
    f_pad *= 2
    state = "#{'.' * f_pad}#{state}"
  end
  new_state = '.' * state.size
  state.chars.each_cons(5).to_a.each_with_index do |part, i|
    new_state[i + 2] = '#' unless notes[part.join].nil?
  end
  state = new_state
  sums << state.chars.map.with_index { |c, i| c == '#' ? i - f_pad : 0 }.sum
end

p state.chars.map.with_index { |c, i| c == '#' ? i - f_pad : 0 }.sum + (50_000_000_000 - 200) * (sums.last - sums[sums.size - 2])

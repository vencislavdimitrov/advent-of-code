input_file = File.read('./15.input').split(',').map(&:to_i)

while input_file.size < 2020
  last = input_file.rindex input_file.last
  first = input_file[0...last].rindex input_file.last
  input_file <<
    if first.nil?
      0
    else
      last - first
    end
end

pp input_file.last

numbers = {}
last = input_file.first
(0...30000000).each do |i|
  if i < input_file.size
    last = input_file[i]
    numbers[last] = [] if numbers[last].nil?
    numbers[last] << i
    next
  end

  last =
    if numbers[last].size >= 2
      numbers[last][-1] - numbers[last][-2]
    else
      0
    end

  numbers[last] = [] if numbers[last].nil?
  numbers[last] << i
end

pp last

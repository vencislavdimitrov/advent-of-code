input = File.read('./1.input').split.map(&:to_i)

p input.sum

frequencies = [0]
loop do
  repeat = false
  input.each do |i|
    frequencies << frequencies.last + i

    if frequencies.count(frequencies.last) > 1
      repeat = true
      break
    end
  end

  break if repeat
end

p frequencies.last

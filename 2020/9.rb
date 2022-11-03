input_file = File.read('./9.input').split("\n").map(&:to_i)

preamble_size = 25
number = nil
(preamble_size..input_file.size - 1).each do |i|
  preamble = false
  (i - preamble_size...i - 1).each do |j|
    (j..i).each do |k|
      if input_file[j] + input_file[k] == input_file[i]
        preamble = true
        break
      end
    end
  end

  unless preamble
    number = input_file[i]
    break
  end
end

pp number

(0..input_file.size - 2).each do |i|
  sum = input_file[i]
  (i + 1..input_file.size - 1).each do |j|
    sum += input_file[j]
    if sum == number
      pp input_file[i..j].min + input_file[i..j].max
    elsif sum > number
      break
    end
  end
end

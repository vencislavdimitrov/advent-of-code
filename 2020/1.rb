input_file = File.read('./1.input').split.map(&:to_i)

(0...(input_file.count - 1)).each do |i|
  (i...input_file.count).each do |j|
    p input_file[i] * input_file[j] if (input_file[i] + input_file[j]) == 2020
  end
end

(0...input_file.count - 2).each do |i|
  (i...input_file.count - 1).each do |j|
    (j...input_file.count).each do |k|
      p input_file[i] * input_file[j] * input_file[k] if (input_file[i] + input_file[j] + input_file[k]) == 2020
    end
  end
end

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.chars

def valid(pass)
  pass.each_cons(3).any? { _1[0].ord == _1[1].ord - 1 && _1[1].ord == _1[2].ord - 1 } &&
    !pass.include?('i') && !pass.include?('o') && !pass.include?('l') &&
    pass.each_cons(2).select { _1[0] == _1[1] && !pass.join.include?(_1[0][0] * 3) }.count >= 2
end

passwords = []
until passwords.size == 2
  passwords << input.join if valid(input)
  add = 1
  (0...input.size).reverse_each do |i|
    break if add == 0

    input[i] = (input[i].ord + add).chr
    if input[i].ord > 'z'.ord
      input[i] = 'a'
    else
      add = 0
    end
  end
end

puts passwords

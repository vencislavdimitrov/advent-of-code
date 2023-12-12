input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.scan(/\d+/).map(&:to_i)

row, column = input

i = 1
j = 1
n = 20_151_125
loop do
  if j == 1
    j = i + 1
    i = 1
  else
    j -= 1
    i += 1
  end

  n = (n * 252_533) % 33_554_393

  break if i == column && j == row
end
p n

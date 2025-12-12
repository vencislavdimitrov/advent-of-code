input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")

dial = 50
zeros = 0
all_zeros = 0
input.each do |i|
  dir, count = i[0], i[1..].to_i
  case dir
  when 'R'
    all_zeros += ((dial + count) / 100)
    dial += count
  when 'L'
    if dial - count <= 0
      all_zeros += (dial - count).abs / 100
      all_zeros += 1 if dial > 0
    end
    dial -= count
  end
  dial %= 100
  zeros += 1 if dial == 0
end

p zeros
p all_zeros


input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip
lengths = input.split(',').map(&:to_i)

def reverse(lengths, n)
  list = (0..255).to_a
  skip = 0
  current = 0
  n.times do
    lengths.each do |length|
      tmp = []
      (0...length).each do |i|
        tmp << list[(current + i) % list.size]
      end
      (0...length).each do |i|
        list[(current + length - 1 - i) % list.size] = tmp[i]
      end
      current += skip + length
      skip += 1
    end
  end
  list
end

p reverse(lengths, 1)[0..1].reduce(&:*)

ascii_input = input.each_byte.to_a + [17, 31, 73, 47, 23]
puts reverse(ascii_input, 64).each_slice(16).map { _1.reduce(&:^).to_s(16) }.map { _1.size == 2 ? _1 : '0' + _1}.join

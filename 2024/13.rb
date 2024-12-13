input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n").map do |m|
  a, b, price = m.split("\n")
  {
    :a => a.scan(/\d+/).map(&:to_i),
    :b => b.scan(/\d+/).map(&:to_i),
    :price => price.scan(/\d+/).map(&:to_i)
  }
end

def calc_tokens(input)
  tokens = 0
  input.each do |machine|
    det = machine[:a][0] * machine[:b][1] - machine[:a][1] * machine[:b][0]
    next if det == 0

    delta_a = machine[:price][0] * machine[:b][1] - machine[:price][1] * machine[:b][0]
    delta_b = machine[:price][1] * machine[:a][0] - machine[:price][0] * machine[:a][1]
    if delta_a % det == 0 && delta_b % det == 0
      a = delta_a / det
      b = delta_b / det
      if a >= 0 && b >= 0
        tokens += 3 * a + b
      end
    end
  end
  tokens
end

p calc_tokens(input)
p calc_tokens(input.map { _1[:price][0] += 10000000000000; _1[:price][1] += 10000000000000; _1 })

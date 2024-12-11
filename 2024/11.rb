input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split(' ').map(&:to_i)

@memo = {}
def iterate(d, i)
  return 1 if i == 0

  @memo[i] ||= {}

  return @memo[i][d] if @memo[i][d]

  @memo[i][d] = if d == 0
    iterate(1, i - 1)
  elsif d.to_s.size.even?
    iterate(d.to_s[...d.to_s.size/2].to_i, i - 1) + iterate(d.to_s[d.to_s.size/2..].to_i, i - 1)
  else
    iterate(d * 2024, i - 1)
  end
end

p input.sum { iterate(_1, 25) }
p input.sum { iterate(_1, 75) }

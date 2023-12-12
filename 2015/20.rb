input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.to_i

def devisors(n)
  small_divisors = (1..Math.sqrt(n) + 1).select { |i| n % i == 0 }
  large_divisors = small_divisors.select { n != _1 * _1 }.map { n / _1 }
  small_divisors + large_divisors
end

elfs = 1
loop do
  devisors = devisors(elfs)
  if devisors.sum * 10 >= input
    p elfs
    break
  end
  elfs += 1
end

loop do
  devisors = devisors(elfs)
  if devisors.select { elfs / _1 <= 50 }.sum * 11 >= input
    p elfs
    break
  end
  elfs += 1
end

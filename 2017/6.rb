input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\t").map(&:to_i)

def find_loop(input)
  cycles = { input.to_s => true }
  loop do
    i = input.index(input.max)
    n = input[i]
    input[i] = 0
    iterations = n / input.size
    input.each_with_index { input[_2] += iterations }

    (n % input.size).times { input[(i + 1 + _1) % input.size] += 1 }

    break if cycles[input.to_s]

    cycles[input.to_s] = true
  end

  cycles.size
end

p find_loop(input)

p find_loop(input)

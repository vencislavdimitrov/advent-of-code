input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.gsub('inc', '+=').gsub('dec', '-=').split("\n").map { _1.split(' ') }

registers = Hash.new(0)
max = -Float::INFINITY
input.map { _1[0] = "registers['#{_1[0]}']"; _1[4] = "registers['#{_1[4]}']"; _1.join(' ') }
  .map { eval _1; max = [registers.values.max, max].max }

p registers.values.max
p max

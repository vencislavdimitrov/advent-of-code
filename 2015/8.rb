input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

p input.map { _1.size - eval(_1).size }.sum

p input.map { _1.dump.size - _1.size }.sum

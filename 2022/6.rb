input = File.read(File.basename(__FILE__).gsub('rb', 'input'))

p input.chars.each_cons(4).find_index { _1.uniq.size == 4 } + 4

p input.chars.each_cons(14).find_index { _1.uniq.size == 14 } + 14

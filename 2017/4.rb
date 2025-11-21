input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ') }

p input.count { |phrase| phrase.count { |word| phrase.count(word) == 1 } == phrase.size }

p input.map { |phrase| phrase.map { _1.chars.sort.join } }.count { |phrase| phrase.count { |word| phrase.count(word) == 1 } == phrase.size }

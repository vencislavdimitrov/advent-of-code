input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

p input.count { |str|
  str.scan(/a|e|i|o|u/).size >= 3 &&
    str.squeeze.length < str.length &&
    !str.include?('ab') &&
    !str.include?('cd') &&
    !str.include?('pq') &&
    !str.include?('xy')
}

p input.count { |str|
  str.chars.each_cons(2).each_with_index.to_a.map { str[_2 + 2..].include?(_1.join) }.any? && str.match(/(\w).\1/)
}


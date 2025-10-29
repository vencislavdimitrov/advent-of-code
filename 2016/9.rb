input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

def decompress(s, part2)
  i = 0
  res = 0
  mul = ''
  while i < s.size
    if s[i] == '('
      mul += s[i]
    elsif s[i] == ')'
      chars, times = mul[1..].split('x').map(&:to_i)
      if part2
        res += decompress(s[i + 1..i + chars], true) * times
      else
        res += s[i + 1..i + chars].size * times
      end
      i += chars
      mul = ''
    elsif mul.empty?
      res += 1
    else
      mul += s[i]
    end
    i += 1
  end
  res
end

p decompress(input, false)
p decompress(input, true)

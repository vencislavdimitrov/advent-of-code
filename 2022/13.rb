input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n\n").map { _1.split("\n").map { |e| eval e } }

def compare(l, r)
  if l.is_a?(Integer) && r.is_a?(Integer)
    l <=> r
  elsif l.is_a?(Array) && r.is_a?(Array)
    i = 0
    while i < l.size && i < r.size
      comp = compare(l[i], r[i])
      return comp unless comp.zero?

      i += 1 if comp.zero?
    end
    return -1 if i == l.size && i < r.size
    return 1 if i < l.size && i == r.size

    0
  elsif l.is_a?(Array) && r.is_a?(Integer)
    compare(l, [r])
  else
    compare([l], r)
  end
end

res = 0
input.each_with_index { res += (_2 + 1) if compare(_1[0], _1[1]) == -1 }

p res

input = input.flatten(1) + [[[2]], [[6]]]
res = input.sort { compare _1, _2 }
p (res.index([[2]]) + 1) * (res.index([[6]]) + 1)

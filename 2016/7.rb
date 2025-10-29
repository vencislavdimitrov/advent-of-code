input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(/\[|\]/)}

def tls(s)
  (0..s.size-4).each do |i|
    return true if s[i...i+4] == s[i...i+4].reverse && s[i...i+4].chars.uniq.count == 2
  end

  return false
end

p input.count { |s| (0...s.size).select(&:even?).any? {|i| tls(s[i])} && (0...s.size).select(&:odd?).all? {|i| !tls(s[i])} }

def find_aba(ss)
  abas = []
  ss.each do |s|
    (0...s.size-2).each do |i|
      abas << s[i..i+2] if s[i] == s[i+2] && s[i] != s[i+1]
    end
  end

  abas.uniq
end

p (input.count do |s|
  abas = find_aba((0...s.size).select(&:even?).map { |i| s[i] })
  babs = find_aba((0...s.size).select(&:odd?).map { |i| s[i] })

  !abas.empty? && (abas.map { |aba| [aba[1], aba[0], aba[1]].join } & babs).size > 0
end)

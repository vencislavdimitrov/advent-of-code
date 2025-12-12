input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split(',')

invalid = 0
invalid2 = 0
input.each do |range|
  from, to = range.split('-').map(&:to_i)
  (from..to).each do |i|
    s = i.to_s
    invalid += i if s[...s.length/2] == s[s.length/2..]

    (1...s.size).each do |seq|
      if s.chars.each_slice(seq).to_a.uniq.size == 1
        invalid2 += i
        break
      end
    end
  end
end

p invalid
p invalid2

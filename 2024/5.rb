rules, prints = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n").map { _1.split("\n") }

prints = prints.map { _1.split(',').map(&:to_i) }

def valid(rules, print)
  (0...print.size-1).each do |i|
    (i+1...print.size).each do |j|
      return false if rules.include?("#{print[j]}|#{print[i]}")
    end
  end
  true
end

p prints.filter { valid(rules, _1) }.map { _1[_1.size/2] }.sum

def fix(rules, print)
  fixed = false
  (0...print.size-1).each do |i|
    (i+1...print.size).each do |j|
      if rules.include?("#{print[j]}|#{print[i]}")
        print[i], print[j] = print[j], print[i]
        fixed = true
      end
    end
  end
  return print if fixed

  false
end

p prints.map { fix(rules, _1) }.filter { _1 }.map { _1[_1.size/2] }.sum

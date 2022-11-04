input = File.read('./5.input').strip

def react(polymer)
  stack = []
  polymer.chars.each do |c|
    if !stack.empty? && (stack.last.ord - c.ord).abs == 32
      stack.pop
    else
      stack << c
    end
  end
  stack
end

p react(input).size

letters = {}
('a'..'z').each do |c|
  letters[c] = react(input.tr(c + c.upcase, '')).size
end
p letters.min_by { |_, v| v }[1]

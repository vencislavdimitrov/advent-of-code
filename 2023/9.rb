input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")
input = input.map { _1.split.map(&:to_i) }

def calc(line)
  history = [line]
  until line.all?(&:zero?)
    line = line.each_cons(2).map { _2 - _1 }
    history << line
  end
  last = nil
  history.each_cons(2) do |a, b|
    b << b.last + a.last
    last = b.last
  end

  history.last.last
end

p input.map { calc(_1) }.sum
p input.map { calc(_1.reverse) }.sum

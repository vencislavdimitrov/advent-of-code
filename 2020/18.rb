input_file = File.read('./18.input').split "\n"

def solve_simple(expr)
  while expr.count('+') + expr.count('*') > 1
    n = 3
    index = expr.each_char.find_index { |c| c == ' ' && (n -= 1).zero? }
    expr = eval(expr[0..index]).to_s + expr[index..]
  end
  eval expr
end

def solve(expr)
  expr.gsub!(/\([^()]*?\)/) { |x| solve_simple x[1..-2] } while expr.include? '('
  solve_simple expr
end

pp input_file.map { |l| solve l.clone }.sum

def solve_simple2(expr)
  expr.gsub!(/(\d)+ \+ (\d)+/) { |x| eval x } while expr.include? '+'
  eval expr
end

def solve2(expr)
  expr.gsub!(/\([^()]*?\)/) { |x| solve_simple2 x[1..-2] } while expr.include? '('
  solve_simple2 expr
end

pp input_file.map { |l| solve2 l.clone }.sum

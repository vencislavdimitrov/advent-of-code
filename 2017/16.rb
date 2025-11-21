input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split(",")

programs = ('a'..'p').to_a

def dance(programs, moves)
  programs = programs.clone
  moves.each do |move|
    case move[0]
    when 's'
      programs = programs[-move[1..].to_i..] + programs[0...programs.size - move[1..].to_i]
    when 'x'
      a, b = move[1..].split('/').map(&:to_i)
      programs[a], programs[b] = programs[b], programs[a]
    when 'p'
      a, b = move[1..].split('/')
      a = programs.index(a)
      b = programs.index(b)
      programs[a], programs[b] = programs[b], programs[a]
    end
  end
  programs
end

puts dance(programs, input).join

memo = {}
step = 0
while step < 1000000000
  if memo[programs.join]
    step = (step - memo[programs.join]) * (1000000000 / (step - memo[programs.join]))
    puts memo.find { _2 == 1000000000 - step }.first
    break
  else
    memo[programs.join] = step
    programs = dance(programs, input)
  end
  step += 1
end

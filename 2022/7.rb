input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

fs = {}
current = []
input.each do |line|
  line_split  = line.split(' ')
  if line_split[1] == 'cd'
    if line_split[2] == '..'
      current.pop
    else
      current << line_split[2]
    end
  elsif line_split[1] != 'ls' && line_split[0] != 'dir'
    (1..current.size).each do |i|
      fs[current.slice(0, i).join('/')] ||= 0
      fs[current.slice(0, i).join('/')] += line_split[0].to_i
    end
  end
end

p fs.values.select { _1 <= 100_000 }.sum

p fs.values.select { _1 >= fs['/'] - (70_000_000 - 30_000_000) }.min

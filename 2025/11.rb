input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { [_1.split(': ')[0], _1.split(': ')[1].split(' ')] }.to_h

def inner_dfs(start, finish, input)
  return 1 if start == finish
  return $memo[start] if $memo[start]
  $memo[start] = input[start]&.sum { inner_dfs(_1, finish, input) } || 0
end

def dfs(start, finish, input)
  $memo = {}
  inner_dfs(start, finish, input)
end

p dfs('you', 'out', input)
p dfs('svr', 'fft', input) * dfs('fft', 'dac', input) * dfs('dac', 'out', input)

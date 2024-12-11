input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(': ') }.map { |line| [line[0].to_i, line[1].split.map(&:to_i)] }

def test(res, values)
  return values[0] == res if values.size == 1

  return test(res, [values[0] + values[1]] + values[2..]) || test(res, [values[0] * values[1]] + values[2..])
end
p input.select { test(_1[0], _1[1]) }.sum(&:first)


def test2(res, values)
  return values[0] == res if values.size == 1

  return test2(res, [values[0] + values[1]] + values[2..]) || test2(res, [values[0] * values[1]] + values[2..]) || test2(res, ["#{values[0]}#{values[1]}".to_i] + values[2..])
end
p input.select { test2(_1[0], _1[1]) }.sum(&:first)

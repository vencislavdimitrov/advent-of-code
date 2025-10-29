input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

def tiles(input, i)
  if i > 0 && i < input.size - 1
    input[i-1..i+1]
  elsif i > 0
    input[i-1..] + '.'
  else
    '.' + input[..i+1]
  end
end

def safe_tiles(input, rows)
  sum_safe_tiles = 0
  rows.times do
    sum_safe_tiles += input.count('.')
    new_tiles = ''
    (0...input.size).each do |i|
      tiles = tiles(input, i)
      new_tiles += case tiles
        when '^^.', '.^^', '^..', '..^'
          '^'
        else
          '.'
        end
    end
    input = new_tiles
  end
  return sum_safe_tiles
end

p safe_tiles(input, 40)
p safe_tiles(input, 400_000)


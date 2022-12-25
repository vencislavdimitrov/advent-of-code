input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

def snafu_to_dec(d)
  chars = {
    '2' => 2,
    '1' => 1,
    '0' => 0,
    '-' => -1,
    '=' => -2
  }
  res = 0
  d.chars.each do |c|
    res = res * 5 + chars[c]
  end

  res
end

def dec_to_snafu(d)
  res = ''
  while d > 0
    if d % 5 == 0
      res += '0'
      d /= 5
    elsif d % 5 == 1
      res += '1'
      d /= 5
    elsif d % 5 == 2
      res += '2'
      d /= 5
    elsif d % 5 == 3
      res += '='
      d = (d + 2) / 5
    else
      res += '-'
      d = (d + 1) / 5
    end
  end
  res.reverse
end

puts dec_to_snafu(input.map { snafu_to_dec _1 }.sum)

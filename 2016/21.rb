input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")

password = 'abcdefgh'
# password = 'abcde'
# input = [
#   'swap position 4 with position 0',
#   'swap letter d with letter b',
#   'reverse positions 0 through 4',
#   'rotate left 1 step',
#   'move position 1 to position 4',
#   'move position 3 to position 0',
#   'rotate based on position of letter b',
#   'rotate based on position of letter d'
# ]

def scramble(password, operation)
  case operation
  when /swap position (\d) with position (\d)/
    password[$1.to_i], password[$2.to_i] = password[$2.to_i], password[$1.to_i]
  when /swap letter (\w) with letter (\w)/
    x = password.index($1)
    y = password.index($2)
    password[x], password[y] = password[y], password[x]
  when /rotate left (\d) step/
    password = password[$1.to_i..] + password[...$1.to_i]
  when /rotate right (\d) step/
    password = password[password.size - $1.to_i..] + password[...password.size - $1.to_i]
  when /rotate based on position of letter (\w)/
    x = password.index($1)
    x += (x >= 4 ? 2 : 1)
    password = password[password.size - x..] + password[...password.size - x]
  when /reverse positions (\d) through (\d)/
    password = password[...$1.to_i] + password[$1.to_i..$2.to_i].reverse + password[$2.to_i + 1..]
  when /move position (\d) to position (\d)/
    l = password[$1.to_i]
    password = password[...$1.to_i] + password[$1.to_i + 1..]
    password = password.insert($2.to_i, l)
  end
  password
end

def unscramble(password, operation)
  case operation
  when /swap position (\d) with position (\d)/
    password[$1.to_i], password[$2.to_i] = password[$2.to_i], password[$1.to_i]
  when /swap letter (\w) with letter (\w)/
    x = password.index($1)
    y = password.index($2)
    password[x], password[y] = password[y], password[x]
  when /rotate left (\d) step/
    password = password[password.size - $1.to_i..] + password[...password.size - $1.to_i]
  when /rotate right (\d) step/
    password = password[$1.to_i..] + password[...$1.to_i]
  when /rotate based on position of letter (\w)/
    x = password.index($1)
    x = x / 2 + (x % 2 == 1 || x == 0 ? 1 : 5)
    password = password.chars.rotate(x).join
    # password = password[x..] + password[...x]
  when /reverse positions (\d) through (\d)/
    password = password[...$1.to_i] + password[$1.to_i..$2.to_i].reverse + password[$2.to_i + 1..]
  when /move position (\d) to position (\d)/
    l = password[$2.to_i]
    password = password[...$2.to_i] + password[$2.to_i + 1..]
    password = password.insert($1.to_i, l)
  end
  password
end

input.each do |operation|
  password = scramble(password, operation)
end
puts password

scrambled_password = 'fbgdceah'
input.reverse_each do |operation|
  scrambled_password = unscramble(scrambled_password, operation)
end
puts scrambled_password

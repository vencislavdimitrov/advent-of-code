input_file = File.read('./2.input').split "\n"

correct_passwords_1 = 0
input_file.each do |line|
  policy, password = line.split ': '
  from_to, letter = policy.split
  from, to = from_to.split('-').map(&:to_i)
  correct_passwords_1 += 1 if password.count(letter).between?(from, to)
end

pp correct_passwords_1

correct_passwords_2 = 0
input_file.each do |line|
  policy, password = line.split ': '
  from_to, letter = policy.split
  from, to = from_to.split('-').map(&:to_i)
  correct_passwords_2 += 1 if (password[from - 1] == letter && password[to - 1] != letter) ||
                            (password[from - 1] != letter && password[to - 1] == letter)
end

pp correct_passwords_2

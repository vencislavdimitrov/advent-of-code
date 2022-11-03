input_file = File.read('./10.input').split("\n").map(&:to_i)

input_file.sort!

one = 1
three = 1
i = 0
while i < input_file.size - 1
  if input_file[i] + 1 == input_file[i + 1]
    j = i + 1
    one += 1
    while j < input_file.size - 1
      if input_file[j] + 1 == input_file[j + 1]
        one += 1
        j += 1
      else
        break
      end
    end
    i = j
  elsif input_file[i] + 3 == input_file[i + 1]
    j = i + 1
    three += 1
    while j < input_file.size - 1
      if input_file[j] + 3 == input_file[j + 1]
        three += 1
        j += 1
      else
        break
      end
    end
    i = j
  else
    i += 1
  end
end

pp one * three

# 0, 1, 2, 3, 4,         7
# 7, 8, 9, 10, 11,       7
# 14,
# 17, 18, 19, 20,        4
# 23, 24, 25,            2
# 28,
# 31, 32, 33, 34, 35,    7
# 38, 39,
# 42,
# 45, 46, 47, 48, 49     7

# 7 * 7 * 4 * 2 * 7 * 7

input_file.prepend 0

groups = []
i = 0
while i < input_file.size - 1
  if input_file[i] + 3 > input_file[i + 1]
    j = i + 1
    j += 1 while j < input_file.size - 1 && input_file[j] + 3 > input_file[j + 1]
    groups << [input_file[i], input_file[j]]
    i = j
  else
    i += 1
  end
end

groups = groups.map do |g|
  case g.max - g.min + 1
  when 1 then 1
  when 2 then 1
  when 3 then 2
  when 4 then 4
  when 5 then 7
  end
end

pp groups.to_a.reduce(1, :*)

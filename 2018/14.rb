input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.to_i

recipes = '37'
elf1 = 0
elf2 = 1

while recipes.size < input + 10
  recipes += (recipes[elf1].to_i + recipes[elf2].to_i).to_s
  elf1 = (elf1 + 1 + recipes[elf1].to_i) % recipes.size
  elf2 = (elf2 + 1 + recipes[elf2].to_i) % recipes.size
end

puts recipes.slice(input, 10)

recipes = "37#{' ' * 20_300_000}"
elf1 = 0
elf2 = 1
size = 2
loop do
  break if (size % 100_000).zero? && recipes.include?(input.to_s)

  (recipes[elf1].to_i + recipes[elf2].to_i).to_s.chars.each do |c|
    recipes[size] = c
    size += 1
  end
  elf1 = (elf1 + 1 + recipes[elf1].to_i) % size
  elf2 = (elf2 + 1 + recipes[elf2].to_i) % size
end

puts recipes.index(input.to_s)

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")

presents = input[...-1].map { _1.split("\n")[1..] }.map { _1.sum { |pr| pr.count('#') } }
trees = input.last.split("\n")

cant_fit = 0
can_fit = 0
unknown = 0
trees.each do |tree|
  sizes, presents_counts = tree.split(': ')
  presents_counts = presents_counts.split(' ').map(&:to_i)
  total_space = sizes.split('x').map(&:to_i).reduce(:*)

  if total_space < presents_counts.map.with_index { presents[_2] * _1 }.sum
    cant_fit +=1
  elsif total_space >= presents_counts.map { _1 * 9 }.sum
    can_fit += 1
  else
    unknown +=1
  end
end

p can_fit

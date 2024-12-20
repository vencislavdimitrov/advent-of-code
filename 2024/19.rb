towels, designs = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n")
towels = towels.split(', ')
designs = designs.split("\n")

@memo = {}
def possible(design, towels)
  if @memo.key?(design)
    return @memo[design]
  end

  @memo[design] = towels.sum do |towel|
    if design == towel
      1
    elsif design.start_with?(towel)
      possible(design[towel.size..], towels)
    else
      0
    end
  end
end

p designs.count { possible(_1, towels).positive? }
p designs.sum { possible(_1, towels) }

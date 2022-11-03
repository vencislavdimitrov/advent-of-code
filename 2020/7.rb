input_file = File.read('./7.input').split("\n")

graph = {}
current_bags = ['shiny gold']
input_file.each do |bags|
  container, bag = bags.split ' contain '
  container = container.split[0..1].join ' '
  bag.split(', ').each do |b|
    b = b.split[1..2].join ' '
    unless b == 'no other bags'
      graph[b] = graph[b].nil? ? [container] : (graph[b] + [container])
    end
  end
end

total = 0
visited = current_bags
while current_bags.size > 0
  new_current_bags = []
  current_bags.each do |bag|
    next if graph[bag].nil?

    new_bags = graph[bag] - visited
    total += new_bags.size
    new_current_bags += new_bags
    visited += new_bags
  end
  current_bags = new_current_bags
end

pp total

graph = {}
input_file.each do |bags|
  container, bag = bags.split ' contain '
  container = container.split[0..1].join ' '
  bag.split(', ').each do |b|
    b = b.split[0..2].join ' '
    unless b == 'no other bags.'
      graph[container] = graph[container].nil? ? [b] : (graph[container] + [b])
    end
  end
end

def rec(graph, current_bag)
  return 1 if graph[current_bag].nil?

  1 + graph[current_bag].map { |b| b.split[0].to_i * rec(graph, b.split[1..2].join(' ')) }.sum
end

pp rec(graph, 'shiny gold') - 1

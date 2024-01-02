input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

graph = {}
input.each do |line|
  left, right = line.split(': ')
  right.split(' ').each do |r|
    graph[left] ||= []
    graph[left] << r
    graph[r] ||= []
    graph[r] << left
  end
end

connections = {}
graph.keys.each do |node|
  visited = {}

  queue = [node]
  until queue.empty?
    current = queue.shift
    visited[current] = true

    graph[current].each do |to|
      next if visited[to] || queue.include?(to)

      connections[[current, to].sort] ||= 0
      connections[[current, to].sort] += 1

      queue << to
    end
  end
end

connections.sort_by { _2 }.last(3).map { _1[0] }.each do |node1, node2|
  graph[node1].delete(node2)
  graph[node2].delete(node1)
end

visited = {}
queue = [graph.keys.first]

until queue.empty?
  current = queue.shift
  visited[current] = true

  graph[current].each do |to|
    next if visited[to] || queue.include?(to)

    queue << to
  end
end

p (graph.size - visited.size) * visited.size

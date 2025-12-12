input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(',').map(&:to_i) }

distances = {}
connections = []

(0...input.size-1).each do |i|
  (i+1...input.size).each do |j|
    x = input[i]
    y = input[j]
    distances[[i,j]] = Math.sqrt((x[0] - y[0])**2 + (x[1] - y[1])**2 + (x[2] - y[2])**2)
  end
end

distances = distances.sort_by { _2 }

distances.each_with_index do |dist, i|
  k = dist[0]
  connection = connections.each_index.select { connections[_1].include?(k[0]) || connections[_1].include?(k[1]) }.to_a
  if connection.empty?
    connections << k
  else
    connections[connection[0]] = connection.map { connections[_1] }.flatten
    (1...connection.size).each do |c|
      connections.delete_at(connection[c])
    end
    connections[connection[0]] = (connections[connection[0]] + k).uniq
  end

  p connections.map(&:size).max(3).reduce(:*) if i == 999
  break p input[k[0]][0] * input[k[1]][0] if connections[0].size == 1000
end

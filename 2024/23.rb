input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split('-') }

parties = Hash.new { |hsh, key| hsh[key] = [] }
input.each do |line|
  parties[line[0]] << line[1]
  parties[line[1]] << line[0]
end

triples = Set[]
visited = Set[]
parties.each do |pc1, connections|
  connections.each do |pc2|
    next if visited.include? [pc1, pc2].sort
    visited << [pc1, pc2].sort
    parties[pc2].each do |pc2_connection|
      next if pc1 == pc2_connection
      triples << [pc1, pc2, pc2_connection].sort if connections.include?(pc2_connection)
    end
  end
end

p triples.count { |triplet| triplet.any? { _1[0] == 't' } }

def connected?(parties, party)
  party.all? do |pc1|
    party.all? do |pc2|
      pc1 == pc2 || parties[pc1].include?(pc2)
    end
  end
end

def max_connected(parties, pc)
  max_connected = []
  (1..parties[pc].size+1).reverse_each do |size|
    ([pc] + parties[pc]).combination(size) do |connected|
      max_connected = connected if connected?(parties, connected) && connected.size > max_connected.size
      break if max_connected.size == size
    end
    break if max_connected.size == size
  end
  max_connected
end

puts parties.keys.map { max_connected(parties, _1) }.max_by { _1.size }.sort.join(',')

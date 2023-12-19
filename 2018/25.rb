input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(',').map(&:to_i) }

def manhattan(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs + (a[2] - b[2]).abs + (a[3] - b[3]).abs
end

def find_constellation(constellations, star)
  constellations.each_with_index do |constellation, i|
    return i if constellation.any? { manhattan(star, _1) <= 3 }
  end
  nil
end

constellations = [[input[0]]]
input[1..].each do |star|
  i = find_constellation(constellations, star)
  if i
    constellations[i] << star
  else
    constellations << [star]
  end
end

loop do
  initial_size = constellations.size
  i = 0
  j = 1
  while i < constellations.size - 1
    while j < constellations.size
      constellations[i].each do |star|
        next unless constellations[j].any? { manhattan(star, _1) <= 3 }

        constellations[i] += constellations[j]
        constellations.delete_at(j)
        j -= 1
        break
      end
      j += 1
    end
    i += 1
    j = i + 1
  end
  break if initial_size == constellations.size
end
p constellations.count

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(', ') }

particles = input.map { {:p => _1[0].scan(/-?\d+/).map(&:to_i), :v => _1[1].scan(/-?\d+/).map(&:to_i), :a => _1[2].scan(/-?\d+/).map(&:to_i)} }

def dist(p1, p2)
  (0..2).map { (p1[_1] - p2[_1]).abs }.sum
end

400.times do
  (0...particles.size).each do |i|
    particles[i][:v][0] += particles[i][:a][0]
    particles[i][:v][1] += particles[i][:a][1]
    particles[i][:v][2] += particles[i][:a][2]
    particles[i][:p][0] += particles[i][:v][0]
    particles[i][:p][1] += particles[i][:v][1]
    particles[i][:p][2] += particles[i][:v][2]
  end
end
p particles.each_with_index.min_by { dist([0, 0, 0], _1[0][:p]) }.last

particles = input.map { {:p => _1[0].scan(/-?\d+/).map(&:to_i), :v => _1[1].scan(/-?\d+/).map(&:to_i), :a => _1[2].scan(/-?\d+/).map(&:to_i)} }
40.times do
  (0...particles.size).each do |i|
    particles[i][:v][0] += particles[i][:a][0]
    particles[i][:v][1] += particles[i][:a][1]
    particles[i][:v][2] += particles[i][:a][2]
    particles[i][:p][0] += particles[i][:v][0]
    particles[i][:p][1] += particles[i][:v][1]
    particles[i][:p][2] += particles[i][:v][2]
  end

  i = 0
  while i < particles.size - 1
    found_duplicate = false
    j = i+1
    while j < particles.size
      if dist(particles[i][:p], particles[j][:p]) == 0
        found_duplicate = true
        particles.delete_at(j)
      else
        j += 1
      end
    end
    if found_duplicate
      particles.delete_at(i)
    else
      i += 1
    end
  end
end
p particles.size

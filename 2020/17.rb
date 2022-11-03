input_file = File.read('./17.input').split

map = [{}]

boundaries = { x: [0, 0], y: [0, 0], z: [0, 0], w: [0, 0] }
def update_boundaries(boundaries, x, y, z, w)
  boundaries[:x][0] = [boundaries[:x][0], x].min
  boundaries[:x][1] = [boundaries[:x][1], x].max
  boundaries[:y][0] = [boundaries[:y][0], y].min
  boundaries[:y][1] = [boundaries[:y][1], y].max
  boundaries[:z][0] = [boundaries[:z][0], z].min
  boundaries[:z][1] = [boundaries[:z][1], z].max
  boundaries[:w][0] = [boundaries[:w][0], w].min
  boundaries[:w][1] = [boundaries[:w][1], w].max
end

(0...input_file.size).each do |i|
  (0...input_file[i].size).each do |j|
    map[0]["x=#{i};y=#{j};z=0;w=0"] = '#' if input_file[i][j] == '#'
    update_boundaries(boundaries, i, j, 0, 0)
  end
end

def count_neighbours(map, x, y, z, w)
  total = 0
  (-1..1).each do |i|
    (-1..1).each do |j|
      (-1..1).each do |k|
        (-1..1).each do |l|
          next if i == 0 && j == 0 && k == 0 && l == 0

          total += 1 if map["x=#{x + i};y=#{y + j};z=#{z + k};w=#{w + l}"]
        end
      end
    end
  end
  total
end

(1..6).each do |i|
  map[i] = map[i - 1].clone
  (boundaries[:x][0] - 1..boundaries[:x][1] + 1).each do |x|
    (boundaries[:y][0] - 1..boundaries[:y][1] + 1).each do |y|
      (boundaries[:z][0] - 1..boundaries[:z][1] + 1).each do |z|
        neighbours = count_neighbours(map[i - 1], x, y, z, 0)
        if map[i - 1]["x=#{x};y=#{y};z=#{z};w=0"]
          unless [2, 3].include? neighbours
            map[i].delete "x=#{x};y=#{y};z=#{z};w=0"
            update_boundaries(boundaries, x, y, z, 0)
          end
        elsif neighbours == 3
          map[i]["x=#{x};y=#{y};z=#{z};w=0"] = '#'
          update_boundaries(boundaries, x, y, z, 0)
        end
      end
    end
  end
end

pp map[6].values.count '#'

(1..6).each do |i|
  map[i] = map[i - 1].clone
  (boundaries[:x][0] - 1..boundaries[:x][1] + 1).each do |x|
    (boundaries[:y][0] - 1..boundaries[:y][1] + 1).each do |y|
      (boundaries[:z][0] - 1..boundaries[:z][1] + 1).each do |z|
        (boundaries[:w][0] - 1..boundaries[:w][1] + 1).each do |w|
          neighbours = count_neighbours(map[i - 1], x, y, z, w)
          if map[i - 1]["x=#{x};y=#{y};z=#{z};w=#{w}"]
            unless [2, 3].include? neighbours
              map[i].delete "x=#{x};y=#{y};z=#{z};w=#{w}"
              update_boundaries(boundaries, x, y, z, w)
            end
          elsif neighbours == 3
            map[i]["x=#{x};y=#{y};z=#{z};w=#{w}"] = '#'
            update_boundaries(boundaries, x, y, z, w)
          end
        end
      end
    end
  end
end

pp map[6].values.count '#'

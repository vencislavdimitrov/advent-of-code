input_file = File.read('./20.input').split "\n\n"

tiles = {}
input_file.each do |tile|
  tile = tile.split("\n")
  tiles[tile[0].gsub(/[^0-9]/, '')] = tile[1..]
end

def match_corner(tiles, index)
  tile = tiles[index]
  first_column = tile.map { |l| l.chars.first }.join
  last_column = tile.map { |l| l.chars.last }.join

  matched_sides = [0, 0, 0, 0]
  tiles.each do |key, t|
    next if key == index

    first_column_t = t.map { |l| l.chars.first }.join
    last_column_t = t.map { |l| l.chars.last }.join

    to_match = [
      t.first,
      t.first.reverse,
      t.last,
      t.last.reverse,
      first_column_t,
      first_column_t.reverse,
      last_column_t,
      last_column_t.reverse
    ]
    matched_sides[0] += 1 if to_match.include? tile.first
    matched_sides[1] += 1 if to_match.include? tile.last
    matched_sides[2] += 1 if to_match.include? first_column
    matched_sides[3] += 1 if to_match.include? last_column
  end

  matched_sides.sum == 2
end

corners = []
tiles.keys.each do |tile_key|
  corners << tile_key.to_i if match_corner tiles, tile_key
end

# # [1693, 2111, 2207, 2339]
pp corners.reduce(1, :*)

def match_next(tiles, pattern, used)
  tiles.each do |key, t|
    next if used.include? key

    first_column = t.map { |l| l.chars.first }.join
    last_column = t.map { |l| l.chars.last }.join

    if pattern == first_column
      return [key, t]
    elsif pattern == first_column.reverse
      return [key, t.reverse]
    elsif pattern == last_column
      return [key, t.map(&:reverse)]
    elsif pattern == last_column.reverse
      return [key, t.map(&:reverse).reverse]
    elsif pattern == t.first
      return [key, t.map(&:chars).transpose.map(&:join)]
    elsif pattern == t.first.reverse
      return [key, t.map { |l| l.chars.reverse }.map(&:join).map(&:chars).transpose.map(&:join)]
    elsif pattern == t.last
      return [key, t.reverse.map(&:chars).transpose.map(&:join)]
    elsif pattern == t.last.reverse
      return [key, t.map { |l| l.chars.reverse }.map(&:join).reverse.map(&:chars).transpose.map(&:join)]
    end
  end
  nil
end

def match_next_col(tiles, pattern, used)
  tiles.each do |key, t|
    next if used.include? key

    first_column = t.map { |l| l.chars.first }.join
    last_column = t.map { |l| l.chars.last }.join

    if pattern == first_column
      return [key, t.map(&:chars).transpose.map(&:join)]
    elsif pattern == first_column.reverse
      return [key, t.reverse.map(&:chars).transpose.map(&:join)]
    elsif pattern == last_column
      return [key, t.map { |l| l.chars.reverse }.map(&:join).map(&:chars).transpose.map(&:join)]
    elsif pattern == last_column.reverse
      return [key, t.map { |l| l.chars.reverse }.map(&:join).reverse.map(&:chars).transpose.map(&:join)]
    elsif pattern == t.first
      return [key, t]
    elsif pattern == t.first.reverse
      return [key, t.map(&:reverse)]
    elsif pattern == t.last
      return [key, t.reverse]
    elsif pattern == t.last.reverse
      return [key, t.map(&:reverse).reverse]
    end
  end
  nil
end

image = tiles['1693'].reverse.clone
image_map = [['1693']]

# assemble first line
(0...11).each do |j|
  pattern = image[0..9].map { |l| l.chars.last }.join
  next_tile = match_next tiles, pattern, image_map.flatten
  image_map[0][j + 1] = next_tile[0]
  (0...image.size).each do |k|
    image[k] += next_tile[1][k]
  end
end

# assemble the rest of the image
(1...12).each do |i|
  image_map << []
  image += Array.new(10, '')
  (0...12).each do |j|
    pattern = image[i * 10 - 1].chars[(j * 10)..(j * 10 + 9)].join
    next_tile = match_next_col tiles, pattern, image_map.flatten
    image_map[i][j + 1] = next_tile[0]
    (0...next_tile[1].size).each do |k|
      image[i * 10 + k] += next_tile[1][k]
    end
  end
end

# remove the borders
(0..image.size).reverse_each do |i|
  if [0, 9].include?(i % 10) && i < image.size - 1
    image.slice! i, 1
    image.map { |l| l.slice! i }
  end
end
image.slice!(image.size - 1, 1)
image.map { |l| l.slice! l.size - 1 }

monster = [
  '                  # ',
  '#    ##    ##    ###',
  ' #  #  #  #  #  #   '
]

monster_indexes = [
  [0, 18],
  [1, 0], [1, 5], [1, 6], [1, 11], [1, 12], [1, 17], [1, 18], [1, 19],
  [2, 1], [2, 4], [2, 7], [2, 10], [2, 13], [2, 16]
]

monsters_count = 0
# image = image.map(&:chars).transpose.map(&:join)
# image = image.reverse.map(&:chars).transpose.map(&:join)
# image = image.map { |l| l.chars.reverse }.map(&:join).map(&:chars).transpose.map(&:join)
# image = image.map { |l| l.chars.reverse }.map(&:join).reverse.map(&:chars).transpose.map(&:join)
# image = image
# image = image.map(&:reverse)
# image = image.reverse
image = image.map(&:reverse).reverse

(0...image.size - 2).each do |i|
  (0...image[i].size - 19).each do |j|
    monsters_count += 1 if monster_indexes.all? { |x, y| image[i + x][j + y] == '#' }
  end
end

pp image.map { |l| l.count '#' }.sum - monsters_count * monster.map { |l| l.count '#' }.sum

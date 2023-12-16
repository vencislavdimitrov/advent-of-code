input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

def count_energized(pos, dir, input)
  energized = {}
  def run(pos, dir, input, energized)
    return if pos[0] < 0 || pos[1] < 0 || pos[0] >= input.size || pos[1] >= input[0].size
    return if energized[pos.to_s] && energized[pos.to_s].include?(dir)

    energized[pos.to_s] ||= []
    energized[pos.to_s] << dir

    new_dir = []
    case input[pos[0]][pos[1]]
    when '.'
      new_dir << dir
    when '/'
      new_dir << case dir
                 when [0, 1]
                   [-1, 0]
                 when [1, 0]
                   [0, -1]
                 when [0, -1]
                   [1, 0]
                 when [-1, 0]
                   [0, 1]
                 end
    when '\\'
      new_dir << case dir
                 when [0, 1]
                   [1, 0]
                 when [1, 0]
                   [0, 1]
                 when [0, -1]
                   [-1, 0]
                 when [-1, 0]
                   [0, -1]
                 end
    when '-'
      case dir
      when [1, 0], [-1, 0]
        new_dir << [0, 1]
        new_dir << [0, -1]
      else
        new_dir << dir
      end
    when '|'
      case dir
      when [0, 1], [0, -1]
        new_dir << [1, 0]
        new_dir << [-1, 0]
      else
        new_dir << dir
      end
    end
    new_dir.each { run([pos[0] + _1[0], pos[1] + _1[1]], _1, input, energized) }
  end
  run(pos, dir, input, energized)

  energized.keys.count
end

p count_energized([0, 0], [0, 1], input)

energized_array = []
(0...input.size).each do |i|
  energized_array << count_energized([0, i], [1, 0], input)
  energized_array << count_energized([input.size - 1, i], [-1, 0], input)
end
(0...input[0].size).each do |i|
  energized_array << count_energized([i, 0], [0, 1], input)
  energized_array << count_energized([i, input[0].size - 1], [0, -1], input)
end
p energized_array.max

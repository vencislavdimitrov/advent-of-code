input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map(&:chars)

class PriorityQueue
  attr_reader :elements

  def initialize(size)
    @elements = [nil]
    @indexes = Array.new(size) { Array.new(size, 0) }
  end

  def <<(element)
    if @indexes[element[0][0]][element[0][1]] > 0
      el_index = @indexes[element[0][0]][element[0][1]]
      if @elements[el_index][1] > element[1]
        @elements[el_index][1] = element[1]
        bubble_up el_index
      else
        @elements[el_index][1] = element[1]
        bubble_down el_index
      end
    else
      @elements << element
      @indexes[element[0][0]][element[0][1]] = @elements.size - 1
      bubble_up(@elements.size - 1)
    end
  end

  def pop
    max_index = @indexes[@elements[1][0][0]][@elements[1][0][1]]
    priority = @elements[max_index][1]
    exchange(1, @elements.size - 1)
    max = @elements.pop[0]
    @indexes[max[0]][max[1]] = 0
    bubble_down(1)
    [max, priority]
  end

  private

  def bubble_up(index)
    parent_index = (index / 2)

    return if index <= 1
    return if @elements[parent_index][1] <= @elements[index][1]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @elements.size - 1

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index] && @elements[child_index][1]
    right_element = @elements[child_index + 1] && @elements[child_index + 1][1]
    child_index += 1 if not_the_last_element && right_element < left_element

    return if @elements[index][1] <= @elements[child_index][1]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
    a = @elements[source][0]
    b = @elements[target][0]
    @indexes[a[0]][a[1]], @indexes[b[0]][b[1]] = @indexes[b[0]][b[1]], @indexes[a[0]][a[1]]
  end
end

def neighbours(input, current)
  [
    [current[0] - 1, current[1]],
    [current[0], current[1] - 1],
    [current[0] + 1, current[1]],
    [current[0], current[1] + 1]
  ].select do |step|
    step[0] >= 0 && step[0] < input.size &&
      step[1] >= 0 && step[1] < input[0].size &&
      input[step[0]][step[1]].ord - input[current[0]][current[1]].ord <= 1
  end
end

def bfs(input, start, finish)
  queue = PriorityQueue.new input[0].size
  queue << [start, 0]
  seen = []

  while queue.elements.any?
    current, dist = queue.pop

    return dist if current == finish
    next if seen.include?(current)

    seen << current

    neighbours(input, current).each do |neighbour|
      queue << [neighbour, dist + 1]
    end
  end
end

finish = [input.map(&:join).join.index('E') / input[0].size, input.map(&:join).join.index('E') % input[0].size]
start = [input.map(&:join).join.index('S') / input[0].size, input.map(&:join).join.index('S') % input[0].size]

input[start[0]][start[1]] = 'a'
input[finish[0]][finish[1]] = 'z'

all_a = []
i = -1
while i = input.map(&:join).join.index('a', i + 1)
  all_a << [i / input[0].size, i % input[0].size]
end

p bfs(input, start, finish)

p all_a.map { bfs(input, _1, finish) }.compact.min

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

$cache = {}
def arrangements(str, template)
  return $cache[str + template.to_s] if $cache[str + template.to_s]

  if str.size == 0
    $cache[str + template.to_s] = template.size.zero? ? 1 : 0
  elsif str[0] == '.'
    $cache[str + template.to_s] = arrangements(str[1..], template)
  elsif str[0] == '?'
    $cache[str + template.to_s] = arrangements(str.sub('?', '.'), template) +
                                  arrangements(str.sub('?', '#'), template)
  elsif str[0] == '#'
    if template.size == 0 || str.size < template[0] || str[0...template[0]].chars.any? { _1 == '.' }
      0
    elsif template.size > 1
      return 0 if str.size < template[0] + 1 || str[template[0]] == '#'

      $cache[str + template.to_s] = arrangements(str[template[0] + 1..], template[1..])
    else
      $cache[str + template.to_s] = arrangements(str[template[0]..], template[1..])
    end
  end

  ### nice and slow
  # if str.index('?').nil?
  #   return str.scan(/#+/).map(&:size) == template ? 1 : 0
  # end

  # [arrangements(str.sub('?', '.'), template), arrangements(str.sub('?', '#'), template)].sum
end

p(input.map do |line|
  arrangements(line.split(' ')[0], line.split(' ')[1].split(',').map(&:to_i))
end.sum)

p(input.map do |line|
  arrangements(([line.split(' ')[0]] * 5).join('?'), line.split(' ')[1].split(',').map(&:to_i) * 5)
end.sum)

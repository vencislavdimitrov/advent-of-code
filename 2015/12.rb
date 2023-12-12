require 'json'
input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

p input.scan(/(-?\d+)/).flatten.map(&:to_i).sum

def json_sum(el)
  sum = 0
  has_red = false

  el.each do |e|
    if e.instance_of?(Array) || e.instance_of?(Hash)
      sum += json_sum(e)
    elsif e.is_a?(Numeric)
      sum += e
    end
  end

  has_red = el.values.any? { _1 == 'red' } if el.instance_of?(Hash)

  if !el.instance_of?(Array) && has_red
    0
  else
    sum
  end
end

p json_sum(JSON.parse(input))

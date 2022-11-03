input_file = File.read('./16.input').split("\n\n")

rules = input_file[0].split "\n"
my_ticket = input_file[1].split[2].split ','
other_tickets = input_file[2].split[2..].map { |l| l.split ',' }

ranges = rules.map { |r| r.gsub(/\d+-\d+/).to_a }.flatten

error_rate = 0
valid_tickets = []
other_tickets.each do |ticket|
  errors = ticket.reject { |t| ranges.any? { |r| t.to_i.between?(r.split('-')[0].to_i, r.split('-')[1].to_i) } }
  error_rate += errors.map(&:to_i).sum
  valid_tickets << ticket if errors.size.zero?
end

pp error_rate

possible = {}
rules.each do |rule|
  possible[rule] = []
  ranges = rule.gsub(/\d+-\d+/).to_a

  (0..rules.size).each do |i|
    possible[rule] << i if valid_tickets.all? do |ticket|
      ranges.any? { |r| ticket[i].to_i.between?(r.split('-')[0].to_i, r.split('-')[1].to_i) }
    end
  end
end

filtered = []
loop do
  rules_to_delete = possible.values.select { |v| v.size == 1 }
  rule_to_delete = nil
  rules_to_delete.each do |r|
    next if filtered.include? r.first

    filtered << r.first
    rule_to_delete = r.first
    break
  end
  break if rule_to_delete.nil?

  possible.values.select { |r| r.size > 1 }.each do |rule|
    rule.delete rule_to_delete
  end
end

total = 1
possible.each do |key, value|
  total *= my_ticket[value.first.to_i].to_i if key.include? 'departure'
end

pp total

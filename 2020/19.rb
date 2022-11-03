input_file = File.read('./19.input').split "\n\n"

rules_input = input_file[0].split "\n"
messages = input_file[1].split "\n"

rules = {}
rules_input.each do |rule|
  rules[rule.split(': ')[0]] = rule.split(': ')[1]
end

while rules['0'].match?(/\d/)
  rules['0'].gsub!(/\s?(\d)+\s?/) { |x| (rules[x.strip].include?('|') ? "(#{rules[x.strip]})" : " #{rules[x.strip]} ") unless rules[x.strip].nil? }
end
rules['0'].gsub!('"', '').gsub!(' ', '')

pp messages.count { |m| m.match? /^#{rules['0']}$/ }

rules = {}
rules_input.each do |rule|
  rules[rule.split(': ')[0]] = rule.split(': ')[1]
end
rules['8'] = '42 | 42 8'
rules['11'] = '42 31 | 42 11 31'
i = 0
while rules['0'].match?(/\d/)
  rules['0'].gsub!(/\s?(\d)+\s?/) do |x|
    unless rules[x.strip].nil?
      i += 1 if ['8', '11'].include? x.strip
      (rules[x.strip].include?('|') ? "(#{rules[x.strip]})" : " #{rules[x.strip]} ") if i < 27
    end
  end
end
rules['0'].gsub!('"', '').gsub!(' ', '')

pp messages.count { |m| m.match? /^#{rules['0']}$/ }

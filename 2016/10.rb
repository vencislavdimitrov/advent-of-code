input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:split)

bots = {}
outputs = {}

input.select { _1[0] == 'value' }.each do |line|
  bots[line[5]] ||= []
  bots[line[5]] << line[1].to_i
  bots[line[5]].sort!
end

loop do
  bot = bots.find { |k, v| v == [17, 61] }
  if bot
    p bot[0].to_i
  end
  bot = bots.find { |k, v| v.size == 2 }

  if bot
    inst = input.find { _1[0] == 'bot' && _1[1] == bot[0] }
    if inst[5] == 'bot'
      bots[inst[6]] ||= []
      bots[inst[6]] << bot[1][0]
      bots[inst[6]].sort!
    else
      outputs[inst[6]] ||= []
      outputs[inst[6]] << bot[1][0]
      outputs[inst[6]].sort!
    end
    if inst[10] == 'bot'
      bots[inst[11]] ||= []
      bots[inst[11]] << bot[1][1]
      bots[inst[11]].sort!
    else
      outputs[inst[11]] ||= []
      outputs[inst[11]] << bot[1][1]
      outputs[inst[11]].sort!
    end
    bots[bot[0]] = []
  else
    break
  end
end
p outputs['0'].first * outputs['1'].first * outputs['2'].first

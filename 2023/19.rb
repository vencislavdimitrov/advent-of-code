input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")

workflows, parts = input
workflows = workflows.split("\n").map { [_1.split('{')[0], _1.split('{')[1][...-1].split(',')] }.to_h
parts = parts.split("\n").map do
  _1[1...-1].split(',').map do |part|
    [part.split('=')[0], part.split('=')[1].to_i]
  end.to_h
end

def process(workflows, part)
  name = 'in'
  loop do
    return false if name == 'R'
    return true if name == 'A'

    workflows[name].each do |workflow|
      return false if workflow == 'R'
      return true if workflow == 'A'

      unless workflow.index(':')
        name = workflow
        break
      end
      w, new_w = workflow.split(':')
      if w[1] == '>'
        if part[w[0]] > w[2..].to_i
          name = new_w
          break
        end
      elsif w[1] == '<'
        if part[w[0]] < w[2..].to_i
          name = new_w
          break
        end
      end
    end
  end
end
p parts.select { process(workflows, _1) }.map { _1.values.sum }.sum

def count_accepted(workflows, name, x, m, a, s)
  return x.size * m.size * a.size * s.size if name == 'A'
  return 0 if name == 'R'

  res = 0
  workflows[name].each do |workflow|
    unless workflow.index(':')
      res += count_accepted(workflows, workflow, x, m, a, s)
      next
    end

    w, new_w = workflow.split(':')
    case w[0]
    when 'x'
      x_accepted, x_rejected = if w[1] == '>'
                                 x.partition { _1 > w[2..].to_i }
                               else
                                 x.partition { _1 < w[2..].to_i }
                               end
      res += count_accepted(workflows, new_w, x_accepted, m, a, s) if x_accepted.size
      x = x_rejected
    when 'm'
      m_accepted, m_rejected = if w[1] == '>'
                                 m.partition { _1 > w[2..].to_i }
                               else
                                 m.partition { _1 < w[2..].to_i }
                               end
      res += count_accepted(workflows, new_w, x, m_accepted, a, s) if m_accepted.size
      m = m_rejected
    when 'a'
      a_accepted, a_rejected = if w[1] == '>'
                                 a.partition { _1 > w[2..].to_i }
                               else
                                 a.partition { _1 < w[2..].to_i }
                               end
      res += count_accepted(workflows, new_w, x, m, a_accepted, s) if a_accepted.size
      a = a_rejected
    when 's'
      s_accepted, s_rejected = if w[1] == '>'
                                 s.partition { _1 > w[2..].to_i }
                               else
                                 s.partition { _1 < w[2..].to_i }
                               end
      res += count_accepted(workflows, new_w, x, m, a, s_accepted) if s_accepted.size
      s = s_rejected
    end
  end
  res
end
p count_accepted(workflows, 'in', (1..4000).to_a, (1..4000).to_a, (1..4000).to_a, (1..4000).to_a)

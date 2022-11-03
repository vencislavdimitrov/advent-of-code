input = File.read('./2.input').split("\n")

grouped_chars = input.map(&:chars).map(&:tally).map(&:values)
p grouped_chars.count { _1.count(2).positive? } * grouped_chars.count { _1.count(3).positive? }

(0...input.size - 1).each do |i|
  (i + 1...input.size).each do |j|
    next if DidYouMean::Levenshtein.distance(input[i], input[j]) != 1

    res = ''
    (0...input[i].size).each do |c|
      res += input[i][c] if input[i][c] == input[j][c]
    end
    puts res
    exit
  end
end

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

input = input.map { _1.scan(/(-?\d+)/).flatten.map(&:to_i) }
max_score = 0
max_cal_score = 0
(1...100).each do |i|
  (1...100).each do |j|
    (1...100).each do |k|
      (1...100).each do |l|
        next if i + j + k + l != 100

        score = [
          [i * input[0][0] + j * input[1][0] + k * input[2][0] + l * input[3][0], 0].max,
          [i * input[0][1] + j * input[1][1] + k * input[2][1] + l * input[3][1], 0].max,
          [i * input[0][2] + j * input[1][2] + k * input[2][2] + l * input[3][2], 0].max,
          [i * input[0][3] + j * input[1][3] + k * input[2][3] + l * input[3][3], 0].max
        ].inject(:*)
        max_score = [max_score, score].max
        if [i * input[0][4] + j * input[1][4] + k * input[2][4] + l * input[3][4]].sum == 500
          max_cal_score = [max_cal_score, score].max
        end
      end
    end
  end
end

p max_score
p max_cal_score

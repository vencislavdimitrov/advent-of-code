buyers = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:to_i)

def calc(d)
  a = (((d * 64) ^ d) % 16777216)
  b = (((a / 32) ^ a) % 16777216)
  ((b * 2048) ^ b) % 16777216
end

p buyers.sum { res = _1; 2000.times { res = calc(res) }; res }

changes = buyers.map do |buyer|
  prices = [buyer]
  2000.times do
    prices << calc(prices.last)
  end
  last_digits = prices.map { _1.digits.first }
  changes = {}
  change = []
  last_digits.each_cons(2).map do |prev, current|
    diff = current - prev
    change << diff
    next if change.size < 4
    changes[change.dup] ||= current
    change.shift
  end
  changes
end

changes_set = changes.map { _1.keys }.flatten(1).uniq

p changes_set.map { |change|
  changes.sum { _1[change] || 0 }
}.max

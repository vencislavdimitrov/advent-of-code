input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

require 'digest'
current = 1
until Digest::MD5.hexdigest(input + current.to_s).start_with?('00000')
  current += 1
end
p current

current = 1
until Digest::MD5.hexdigest(input + current.to_s).start_with?('000000')
  current += 1
end
p current

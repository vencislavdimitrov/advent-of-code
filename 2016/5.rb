require 'digest'

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

door_id = input

i = 0
password = ''
while password.size < 8
  hash = Digest::MD5.hexdigest(door_id + i.to_s)
  password += hash[5] if hash[0...5] == '00000'
  i += 1
end
p password

i = 0
password = '_' * 8
while password.chars.count('_') > 0
  hash = Digest::MD5.hexdigest(door_id + i.to_s)
  if hash[0...5] == '00000'
    password[hash[5].to_i] = hash[6] if hash[5].to_i.to_s == hash[5] && password[hash[5].to_i] == '_'
  end
  i += 1
end
p password

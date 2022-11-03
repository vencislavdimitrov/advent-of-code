card_pk, door_pk = File.read('./25.input').split.map(&:to_i)

def key(subject, loop)
  key = 1
  loop.times do
    key = (key * subject) % 20201227
  end
  key
end

i = 1
key = 1
loop do
  key = (key * 7) % 20201227
  break if key == card_pk

  i += 1
end

pp key(door_pk, i)

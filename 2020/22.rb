input_file = File.read('./22.input').split "\n\n"

player1 = input_file[0].split("\n")[1..].map(&:to_i)
player2 = input_file[1].split("\n")[1..].map(&:to_i)

def play(player1, player2)
  while !player1.empty? && !player2.empty?
    if player1.first > player2.first
      player1 = player1[1..] + [player1.first, player2.first]
      player2 = player2[1..]
    else
      player2 = player2[1..] + [player2.first, player1.first]
      player1 = player1[1..]
    end
  end

  return player1 if player2.empty?

  player2
end

pp play(player1, player2).reverse.each_with_index.map { |card, i| card * (i + 1) }.sum

player1 = input_file[0].split("\n")[1..].map(&:to_i)
player2 = input_file[1].split("\n")[1..].map(&:to_i)

already_played = []

def play2(player1, player2)
  already_played = []
  while !player1.empty? &&
        !player2.empty? &&
        !already_played.include?([player1.join, player2.join].join('_'))
    already_played << [player1.join, player2.join].join('_')
    if player1.first < player1.size && player2.first < player2.size
      if play2(player1.slice(1, player1.first), player2.slice(1, player2.first))[0] == :player1
        player1 = player1[1..] + [player1.first, player2.first]
        player2 = player2[1..]
      else
        player2 = player2[1..] + [player2.first, player1.first]
        player1 = player1[1..]
      end
    elsif player1.first > player2.first
      player1 = player1[1..] + [player1.first, player2.first]
      player2 = player2[1..]
    else
      player2 = player2[1..] + [player2.first, player1.first]
      player1 = player1[1..]
    end
  end

  return [:player1, player1] if already_played.include?([player1.join, player2.join].join('_')) || player2.empty?

  [:player2, player2]
end

winner = play2(player1, player2)
pp winner[1].reverse.each_with_index.map { |card, i| card * (i + 1) }.sum

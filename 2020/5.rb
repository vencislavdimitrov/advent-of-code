input_file = File.read('./5.input').split

def find_row(input)
  up = 127
  down = 0
  input.chars.each do |c|
    if c == 'F'
      up = (down + up) / 2
    elsif c == 'B'
      down = ((down + up) / 2.to_f).ceil
    end
  end
  down
end

def find_column(input)
  right = 7
  left = 0
  input.chars.each do |c|
    if c == 'L'
      right = (left + right) / 2
    elsif c == 'R'
      left = ((left + right) / 2.to_f).ceil
    end
  end
  left
end

seat = input_file.max_by { |seat| find_row(seat[0..6]) * 8 + find_column(seat[7..]) }
pp find_row(seat[0..6]) * 8 + find_column(seat[7..])

sorted_seats = input_file.map { |seat| find_row(seat[0..6]) * 8 + find_column(seat[7..]) }.sort

pp (sorted_seats.min..sorted_seats.max).to_a - sorted_seats

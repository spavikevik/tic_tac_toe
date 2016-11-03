require_relative 'board'
require_relative 'player'

b = Board.new
puts "Please enter name for player 1: "
p1 = Player.new(gets.chomp.capitalize, "X")
puts "Please enter name for player 2: "
p2 = Player.new(gets.chomp.capitalize, "O")
puts "=" * 13
puts b

player_in_turn = p1

loop do
  print "#{player_in_turn.name}'s turn.\n\nPlease enter coordinates for your next move (eg. a, 2) = "
  begin
    coordinates = gets
    b.play(player_in_turn, coordinates)
  rescue ArgumentError => e
    puts e.message
    print "Please enter coordinates again: "
    retry
  end
  puts b
  if player_in_turn == p1
    player_in_turn = p2
  else
    player_in_turn = p1
  end
  winner = b.win_or_tie?
  if winner == :tie
    puts "A tie!"
    break
  elsif winner
    puts "#{winner.name} wins!"
    break
  else
    next
  end
end

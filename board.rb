class Board
  def initialize
    @state = {a: ["*"]*3, b: ["*"]*3, c: ["*"]*3}
    @moves = 9
  end

  def to_s
    format_state + "\n"
  end

  def play(player, move)
    move = move.split(',')
    row, col = move[0].chomp.to_sym, move[1].chomp.to_i
    begin
      make_move(row, col, player)
      decrement_moves
    rescue InvalidMoveException
      raise ArgumentError, "Field out of bounds / field already played!"
    end
  end

  def win_or_tie?
    winner = check_win?
    if winner && winner != "*"
      return winner
    elsif winner == "*" && moves == 0
      return :tie
    else
      return nil
    end
  end

  private
    def state
      @state
    end

    def moves
      @moves
    end

    def decrement_moves
      @moves -= 1
    end

    def format_state
      str = "\n     0   1   2\n   #{'-'*13}\n"
      state.each do |k, v|
        str += " #{k} | #{v[0]} | #{v[1]} | #{v[2]} |\n   #{'-'*13}\n"
      end
      return str
    end

    def make_move(r, c, player)
      raise InvalidMoveException if !(:a..:c).include?(r) || !(0..2).include?(c) || @state[r][c] != "*"
      @state[r][c] = player
    end

    def check_win?
      0.upto(2) do |i|
      return state[:a][i] if state[:a][i] == state[:b][i] && state[:a][i] == state[:c][i]
      end
      'a'.upto('c') do |c|
        c = c.to_sym
        return state[c][0] if state[c][0] == state[c][1] && state[c][0] == state[c][2]
      end
      return state[:a][0] if state[:a][0] == state[:b][1] && state[:a][0] == state[:c][2]
      return state[:a][2] if state[:a][2] == state[:b][1] && state[:a][2] == state[:c][1]
      return nil
    end
end

class InvalidMoveException < ArgumentError
end

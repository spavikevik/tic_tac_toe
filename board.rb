class Board
  def initialize
    @state = {a: ["*"]*3, b: ["*"]*3, c: ["*"]*3}
  end

  def to_s
    format_state + "\n"
  end

  def play(player, move)
    move = move.split(',')
    row, col = move[0].chomp.to_sym, move[1].chomp.to_i
    begin
      make_move(row, col, player)
    rescue InvalidMoveException
      raise ArgumentError, "Field out of bounds / field already played!"
    end
  end

  def win_or_tie?
    return check_win?
  end

  private
    def state
      @state
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

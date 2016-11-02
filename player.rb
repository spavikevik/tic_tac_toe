class Player
  attr_accessor :name
  attr_reader :s

  def initialize(name, s)
    @name = name
    @s = s
  end

  def to_s
    s
  end
end

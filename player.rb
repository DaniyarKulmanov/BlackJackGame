class Player
  attr_accessor :money, :cards
  attr_reader :name, :points, :gender

  def initialize(name, gender)
    @name = name
    @gender = GENDER[gender.to_sym]
    @money = 100
    @cards = []
    @points = 0
  end

end

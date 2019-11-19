class Player
  attr_accessor :money, :cards, :points
  attr_reader :name, :gender

  def initialize(name, gender)
    @name = name
    @gender = GENDER[gender.to_sym]
    @money = 100
    @cards = []
    @points = 0
  end

  def take(cards)
    @cards.push cards.sample
  end
end

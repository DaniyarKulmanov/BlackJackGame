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

  def count_points
    # посчитать сумму очков
    # добавить логику туза, если прибавить 11 и сумма выше 21 то прибавлять 1
    @cards.each { |card| @points += card[:points] }
  end
end

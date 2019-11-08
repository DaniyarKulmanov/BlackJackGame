class Player
  attr_writer :money, :cards
  attr_reader :name, :points

  def initialize(name)
    @name = name
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

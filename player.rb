require_relative 'card'

class Player
  BOY = "\u{1F466}"
  GIRL = "\u{1F467}"
  GENDER = { М: BOY, Ж: GIRL }.freeze

  attr_accessor :money, :cards, :points, :sums
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

  def count_points
    @points = 0
    my_cards = Card.new @cards, @points
    my_cards.count_simple_cards
    my_cards.count_aces
    @points = my_cards.points
  end
end

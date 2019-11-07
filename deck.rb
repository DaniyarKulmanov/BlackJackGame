class Deck
  NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'D', 'E'].freeze
  SUITS = %w[A B C D].freeze

  def initialize
    @cards ||= []
    collect @cards
  end

  def collect(cards)
    
  end
end

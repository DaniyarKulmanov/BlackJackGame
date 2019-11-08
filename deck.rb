require_relative 'data'
# working deck
class Deck
  attr_accessor :cards

  def initialize
    @cards ||= []
    collect @cards
  end

  def random_card
    card = cards.sample
    @cards.delete card
    card unless card.nil?
  end

  private

  def collect(cards)
    SUITS.each do |suit|
      NUMBERS.each { |number| cards << create_card(suit, number) }
    end
  end

  def create_card(suit, number)
    card_details = {}
    card_details[:card] = ''
    card_details[:card] << convert_unicode(suit, number)
    card_details[:points] = count_points(number)
    card_details[:alter_points] = 11 if ACES.include? card_details[:card]
    card_details
  end

  def convert_unicode(suit, number)
    "#{PREFIX}#{suit}#{number}".to_i(16)
  end

  def count_points(number)
    (1..9).include?(number.to_i) ? number.to_i : 10
  end
end

require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards ||= []
    collect cards
    shuffle cards
  end

  def random_card
    card = cards.sample
    @cards.delete card
    card unless card.nil?
  end

  private

  Card::NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'D', 'E'].freeze
  Card::SUITS = %w[A B C D].freeze
  ACES = ["\u{1F0A1}", "\u{1F0B1}", "\u{1F0C1}", "\u{1F0D1}"].freeze
  PREFIX = '1F0'.freeze

  def collect(cards)
    Card::SUITS.each do |suit|
      Card::NUMBERS.each { |number| cards << create_card(suit, number) }
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

  def shuffle(cards)
    cards.shuffle! unless cards.nil?
  end
end

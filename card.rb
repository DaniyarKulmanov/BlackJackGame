class Card

  NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'D', 'E'].freeze
  SUITS = %w[A B C D].freeze
  ACES = ["\u{1F0A1}", "\u{1F0B1}", "\u{1F0C1}", "\u{1F0D1}"].freeze
  MAX_POINTS = 21

  attr_accessor :sums, :points
  attr_reader :cards

  def initialize(cards, points)
    @cards = cards
    @points = points
  end

  def count_simple_cards
    simple_cards = @cards.select(&:alter_points?)
    simple_cards.sum(&:card_points)
  end

  def count_aces
    aces_cards = @cards.select { |card| ACES.include? card[:card] }
    possible_sums aces_cards unless aces_cards.empty?
    unless aces_cards.empty?
      @sums.map! { |sum| sum += @points }
      @sums.sort!
      @points = @sums.select { |sum| sum <= MAX_POINTS }.last
    end
  end

  def possible_sums(cards)
    @sums = [0, 0, 0]
    cards.each do |ace|
      @sums[2] = @sums[0]
      @sums[0] += ace[:points]
      @sums[1] += ace[:alter_points]
      @sums[2] += ace[:alter_points]
    end
  end

  private

  def alter_points?
    self[:alter_points].nil?
  end

  def card_points
    self[:points]
  end
end

module Enumerable
  def alter_points?
    self[:alter_points].nil?
  end

  def card_points
    self[:points]
  end
end

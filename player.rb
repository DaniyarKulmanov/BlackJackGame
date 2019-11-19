class Player
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
    count_simple_cards
    count_aces
  end

  private

  def count_simple_cards
    simple_cards = cards.select { |card| card[:alter_points].nil? }
    simple_cards.each { |card| @points += card[:points] }
  end

  def count_aces
    aces_cards = cards.select { |card| ACES.include? card[:card] }
    possible_sums aces_cards unless aces_cards.empty?
    unless aces_cards.empty?
      @sums.map! { |sum| sum += player.points }
      @sums.sort!
      player.points = @sums.select { |sum| sum <= 21 }.last
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
end

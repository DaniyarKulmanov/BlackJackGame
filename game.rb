require_relative 'data'
require_relative 'dealer'
require_relative 'deck'

class Game

  def initialize(user)
    @player = user
    @dealer = Dealer.new
    @cards ||= []
    @bank = 0
    lost
  end

  def game_start
    loop do
      prepare_round
      play_round
      # break if user want to quit game
      # break if dealer.money.zero? || user.money.zero?
      # puts user.quit
      # break if no_money? || user.quit
      break
    end
  end

  private

  attr_accessor :player, :dealer, :cards, :bank, :sums

  def prepare_round
    init_game_attributes
    default_cards player
    default_cards dealer
    make_bet player
    make_bet dealer
  end

  def play_round
    # loop do
    # player.move(self)
    # move dealer
    # end
    show_result
  end

  def no_money?
    player.money.zero? || dealer.money.zero?
  end

  def lost
    puts "#{player.name} #{LOSE}"
    (1..5).each { print "#{SORRY} " }
    puts ''
  end

  def end_game
    puts "#{FAREWELL} #{player.name}"
  end

  def make_bet(player)
    @bank += 10
    player.money -= 10
  end

  def show_result
    count_points player
    count_points dealer
    print_result
  end

  def count_points(player)
    player.points = 0
    count_simple_cards player
    count_aces player
  end

  def count_simple_cards(player)
    simple_cards = player.cards.select { |card| card[:alter_points].nil? }
    simple_cards.each { |card| player.points += card[:points] }
    # puts player.points
  end

  def count_aces(player)
    aces_cards = player.cards.select { |card| ACES.include? card[:card] }
    @sums = possible_sums aces_cards unless aces_cards.empty?
    unless aces_cards.empty?
      @sums.map! { |sum| sum += player.points }
      @sums.sort!
      player.points = @sums.select { |sum| sum <= 21 }.last
    end
  end

  def possible_sums(cards)
    sums = [0, 0, 0]
    cards.each do |ace|
      sums[2] = sums[0]
      sums[0] += ace[:points]
      sums[1] += ace[:alter_points]
      sums[2] += ace[:alter_points]
    end
    sums
  end

  def init_game_attributes
    @cards = Deck.new.cards
    @sums = []
    player.cards = []
    dealer.cards = []
  end

  def default_cards(player)
    2.times { player.take cards }
    @cards -= player.cards
  end

  def print_result
    puts "player points = #{player.points}"
    puts "player cards = #{player.cards}"
  end
end

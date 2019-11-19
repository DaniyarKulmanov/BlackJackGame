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

  attr_accessor :player, :dealer, :cards, :bank

  def prepare_round
    init_game_attributes
    make_bet player
    make_bet dealer
  end

  def play_round
    # loop do
    # player decide
    # give_card player
    # move dealer
    # dealer decide
    # give_card dealer
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
    player.count_points
    dealer.count_points
    print_result
  end

  def init_game_attributes
    @cards = Deck.new.cards
    player.cards = []
    dealer.cards = []
    2.times { give_card player }
    2.times { give_card dealer }
  end

  def give_card(player)
    @cards -= player.take @cards
  end

  def print_result
    puts "player points = #{player.points}"
    puts "player cards = #{player.cards}"
  end
end

require_relative 'data'
require_relative 'dealer'
require_relative 'deck'

class Game

  def initialize(user)
    @user = user
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
      puts user.quit
      break if money? || user.quit
    end
  end

  private

  attr_accessor :user, :dealer, :cards, :bank

  def prepare_round
    @cards = Deck.new.cards
    take cards, user
    take cards, dealer
    make_bet user
    make_bet dealer
  end

  def play_round
    # loop do
    # move user
    # move dealer
    # user.money = 0
    # dealer.money = 0
    # end
    # show result
  end

  def money?
    user.money.zero? || dealer.money.zero?
  end

  def lost
    puts "#{user.name} #{LOSE}"
    (1..5).each { print "#{SORRY} " }
    puts ''
  end

  def end_game
    puts "#{FAREWELL} #{username}"
  end

  def take(cards, player)
    player.cards = []
    2.times do
      player.cards.push cards.sample
    end
    @cards -= player.cards
  end

  def make_bet(player)
    @bank += 10
    player.money -= 10
  end
end

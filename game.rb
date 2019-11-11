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
    # loop do
    prepare_round
    # round
    # break if user want to quit game
    # break if dealer.money.zero? || user.money.zero?
    # end
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

  def round
    loop do
    # move user
    # move dealer
    break if stop_round?
    end
    # show result
  end

  def stop_round?
    # user || dealer money.zero?
    # true if dealer.points > 21 || user.points > 21
    # true if user input == open cards
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

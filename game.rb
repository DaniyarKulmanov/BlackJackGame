require_relative 'data'
require_relative 'dealer'
require_relative 'deck'

class Game

  def initialize(user)
    @player = user
    @dealer = Dealer.new
    @cards ||= []
    @bank = 0
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
    @cards = Deck.new.cards
    player.cards = []
    dealer.cards = []
    2.times { give_card_to player }
    2.times { give_card_to dealer }
    make_bet player
    make_bet dealer
  end

  def play_round
    loop do
      break if player.cards.size == 3 && dealer.cards.size == 3
      round_result
      puts ROUND_MENU
      input = gets.chomp.strip
      case input
      when DESIRE[:pass]
        dealer_move
      when DESIRE[:add]
        give_card_to player if player.cards.size < 3
        dealer_move
      when DESIRE[:open]
        break
      end
    end
    round_result #change
  end

  def dealer_move
    give_card_to dealer if dealer.points < 17 && dealer.cards.size < 3
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

  def round_result
    player.count_points
    dealer.count_points
    print_result
  end

  def give_card_to(player)
    @cards -= player.take @cards
  end

  def print_result
    puts "player points = #{player.points}"
    puts "player cards = #{player.cards}"
    puts "Dealer points = #{dealer.points}"
    puts "Dealer cards = #{dealer.cards}"
  end
end

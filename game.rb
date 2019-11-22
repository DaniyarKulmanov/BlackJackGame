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

  def launch
    loop do
      prepare_round
      play_round
      break if dealer.money.zero? || player.money.zero?
      puts '0. Закончить партую'
      input = gets.chomp.strip
      break if input == '0'
    end
  end

  private

  attr_accessor :player, :dealer, :cards, :bank

  def prepare_round
    @bank = 0
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
      round_information false
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
    round_result
  end

  def dealer_move
    give_card_to dealer if dealer.points < 17 && dealer.cards.size < 3
  end

  def no_money?
    player.money.zero? || dealer.money.zero?
  end

  def end_game
    puts "#{FAREWELL} #{player.name}"
  end

  def make_bet(player)
    @bank += 10
    player.money -= 10
  end

  def round_information(show)
    player.count_points
    dealer.count_points
    current_state show
  end

  def give_card_to(player)
    @cards -= player.take @cards
  end

  def current_state(show)
    system "clear" unless show
    puts "Деньги дилера #{dealer.money}$, карты дилера:"
    dealer.cards.size.times { print "#{CLOSED_CARDS} " } unless show
    dealer.cards.each { |card| print "#{card[:card]} " } if show
    puts ''
    puts "Очки дилера #{dealer.points}" if show
    puts "Деньги #{player.money}$, Ваши карты:"
    player.cards.each { |card| print "#{card[:card]} " }
    puts ''
    puts "Ваши очки = #{player.points}"
  end

  def round_result
    player.count_points
    dealer.count_points
    if both_lost_or_equal
      draw
    else
      winner player if player_win
      winner dealer if dealer_win
    end
    round_information true
  end

  def both_lost_or_equal
    (player.points > 21 && dealer.points > 21) || player.points == dealer.points
  end

  def player_win
    player.points > dealer.points && player.points <= 21 || player.points <= 21 && dealer.points > 21
  end

  def dealer_win
    dealer.points > player.points && dealer.points <= 21 || dealer.points <= 21 && player.points > 21
  end

  def winner(player)
    puts "победил #{player.name}!"
    player.money += bank
  end

  def draw
    puts 'Ничья'
    player.money += 10
    dealer.money += 10
  end
end

require_relative 'dealer'
require_relative 'deck'
require_relative 'interface'
require_relative 'user'

class Game
  WIN = 21

  def initialize
    @player = User.new Interface.ask_name, Interface.ask_gender
    @dealer = Dealer.new
    @cards ||= []
    @bank = 0
  end

  def launch
    loop do
      prepare_round
      play_round
      break if no_money?
      break if Interface.quit_game == '0'
    end
  end

  private

  DESIRE = { pass: '1', add: '2', open: '3' }.freeze

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
      input = Interface.round_menu
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
    give_card_to dealer if dealer.points < Dealer::MAX && dealer.cards.size < 3
  end

  def no_money?
    player.money.zero? || dealer.money.zero?
  end

  def make_bet(player)
    @bank += 10
    player.money -= 10
  end

  def round_information(show)
    player.count_points
    dealer.count_points
    Interface.current_state show, dealer, player
  end

  def give_card_to(player)
    @cards -= player.take @cards
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
    (player.points > 21 && dealer.points > WIN) || player.points == dealer.points
  end

  def player_win
    player.points > dealer.points && player.points <= WIN || player.points <= WIN && dealer.points > WIN
  end

  def dealer_win
    dealer.points > player.points && dealer.points <= WIN || dealer.points <= WIN && player.points > WIN
  end

  def winner(player)
    Interface.print_winner player
    player.money += bank
  end

  def draw
    Interface.print_draw
    player.money += 10
    dealer.money += 10
  end
end

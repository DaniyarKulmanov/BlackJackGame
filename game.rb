require_relative 'data'
require_relative 'dealer'
require_relative 'deck'

class Game

  def self.count_points(player)
    count_simple player
    count_aces player
  end

  def self.count_simple(player)
    simple_cards = player.cards.select { |card| card[:alter_points].nil? }
    simple_cards.each { |card| player.points += card[:points] }
  end

  def self.count_aces(player)
    aces_cards = player.cards.select { |card| ACES.include? card[:card] }
    # puts aces_cards
    sum1 = 0
    sum2 = 0
    sum3 = 0
    sums = []
    aces_cards.each do |ace|
      sum3 = sum1
      sum1 += ace[:points]
      sum2 += ace[:alter_points]
      sum3 += ace[:alter_points]
      # if player.points + ace[:alter_points] >= 21
      #   player.points = player.points - ace[:alter_points] + ace[:points]
      # else
      #   player.points += ace[:alter_points]
      # end
    end
    sums = [sum1, sum2, sum3]
    sums.map! { |sum| sum += player.points }
    puts sums
    puts "nearest:"
    sums.sort!
    player.points = sums.select { |sum| sum <= 21 }.last
    # check if sum >=21 and 2 or 3 aces
    puts "player pts - #{player.points}"
  end

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
      # puts user.quit
      # break if no_money? || user.quit
      break
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
    show_result
  end

  def no_money?
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

  def show_result
    count_points user
    count_points dealer
  end



  def aces_points(sums, player)
    # nearest21 = sums.sort.group_by{ |points| points <=> 21 }
    # fix_sum = nearest21[-1].last || nearest21[1].first
    # player.points = fix_sum
    a = 21 - sums[0]
    b = 21 - sums[1]
    nearest21 = a > b ? a : b
  end
end

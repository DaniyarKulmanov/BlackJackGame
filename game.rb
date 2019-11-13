require_relative 'data'
require_relative 'dealer'
require_relative 'deck'

class Game

  def self.count_points(player)
    # посчитать сумму очков
    # добавить логику туза, если прибавить 11 и сумма выше 21 то прибавлять 1
    alter_sum = 0
    sum = 0
    player.cards.each do |card|
      alter_sum += card[:alter_points] unless card[:alter_points].nil?
      alter_sum += card[:points] if card[:alter_points].nil?
      sum += card[:points]
      puts "alter_sum = #{alter_sum}, sum = #{sum}"
      player.points = alter_sum <= 21 ? alter_sum : sum
    end
    puts 'after'
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

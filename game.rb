require_relative 'data'
require_relative 'deck'

class Game



  def initialize(user)
    @username = user
    @dealer = Dealer.new
    @bank = 0
    lost
  end

  def game_start
    # loop do
    prepare_round
    round
    # break if user want to quit game
    # break if dealer.money.zero? || user.money.zero?
    # end
  end

  private

  attr_accessor :username, :dealer

  def prepare_round
    # give 2 cards
    # take 10 money from both
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
    # if dealer.points > 21 || user.points > 21
    # user input == open cards
  end

  def lost
    puts "#{username} #{LOSE}"
    (1..5).each { print "#{SORRY} " }
    puts ''
  end

  def end_game
    puts "#{FAREWELL} #{username}"
  end
end

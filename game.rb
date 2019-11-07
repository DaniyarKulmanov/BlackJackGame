require_relative 'data'
require_relative 'deck'

class Game

  attr_reader :username

  def initialize(username)
    @username = username
    @dealer_money = 100
    @user_money = 100
    lost
  end

  private

  def lost
    puts "#{username} #{LOSE}"
    (1..5).each { print "#{SORRY} " }
    puts ''
  end

  def end_game
    puts "#{FAREWELL} #{username}"
  end
end

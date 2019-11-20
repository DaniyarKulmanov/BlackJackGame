require_relative 'game'
require 'colorize'
require_relative 'dealer'
require_relative 'user'

puts ASK_NAME
name = gets.chomp
gender = ''

loop do
  puts ASK_GENDER
  gender = gets.chomp
  break if GENDERS.include? gender
end
# нарисовать круглы покерный стол
user = User.new name, gender
game = Game.new user
game.game_start

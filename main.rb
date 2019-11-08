require_relative 'game'
require 'colorize'
require_relative 'dealer'
require_relative 'user'

puts ASK_NAME
puts ASK_GENDER
# нарисовать круглы покерный стол
Game.new gets.chomp
dealer = Dealer.new
puts dealer.gender.light_blue

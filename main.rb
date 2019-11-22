require_relative 'game'
require 'colorize'
require_relative 'dealer'
require_relative 'user'

puts ASK_NAME
name = gets.chomp
gender = ''

loop do
  puts ASK_GENDER
  gender = gets.chomp.strip
  break if GENDERS.include? gender
end
system 'clear'
user = User.new name, gender
game = Game.new user
game.launch

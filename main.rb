require_relative 'game'
require 'colorize'

puts "\u{1F466}".light_blue
puts "\u{1F467}".green

puts ASK_NAME
# нарисовать круглы покерный стол
Game.new gets.chomp

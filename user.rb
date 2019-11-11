require_relative 'player'

class User < Player
  attr_reader :quit

  def move
    @quit = false
    puts '1.'
    puts 'Q'
    input = gets.chomp
    @quit = true if input == 'Q'
  end
  #Пропустить
  #Добавить карту
  #Открыть карты
end

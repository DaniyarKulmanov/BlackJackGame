require_relative 'player'

class User < Player
  attr_reader :quit

  def move(game)
    @quit = false
    puts '1.'
    puts 'Q'
    game.take cards, self
    input = gets.chomp
    @quit = true if input == 'Q'
  end
  #Пропустить
  #Добавить карту
  #Открыть карты
end

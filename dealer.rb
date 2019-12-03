require_relative 'player'

class Dealer < Player
  MAX = 17

  def initialize
    super 'Дилер', [:М, :Ж].sample
  end
end

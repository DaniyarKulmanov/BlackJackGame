require_relative 'player'

class Dealer < Player
  def initialize
    super 'Дилер', [:М, :Ж].sample
  end
end

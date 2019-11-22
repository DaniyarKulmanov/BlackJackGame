require_relative 'player'
require_relative 'data'

class Dealer < Player
  def initialize
    super 'Дилер', [:М, :Ж].sample
  end
end

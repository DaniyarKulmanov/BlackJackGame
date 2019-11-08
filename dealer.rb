require_relative 'player'
require_relative 'data'

class Dealer < Player
  def initialize
    super 'Dealer', [:М, :Ж].sample
  end
  # if points < 17 take card
end

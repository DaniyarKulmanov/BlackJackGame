require_relative 'player'
require_relative 'dealer'
require_relative 'user'
require_relative 'data'

class Dealer < Player
  def initialize
    super 'Dealer', [BOY, GIRL].sample
  end
  # if points < 17 take card
end

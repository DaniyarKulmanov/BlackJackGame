class Player
  attr_writer :money
  attr_reader :name

  def initialize(name)
    @name = name
    @money = 100
  end
end

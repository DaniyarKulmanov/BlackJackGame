module Interface
  CLOSED_CARDS = "\u{1F0A0}".freeze

  module_function

  def ask_name
    puts 'Как Вас зовут?'
    gets.chomp
  end

  def ask_gender
    puts 'Укажите Ваш пол, введите М или Ж'
    gets.chomp.strip
  end

  def quit_game
    puts '0.Закончить партую'
    gets.chomp.strip
  end

  def round_menu
    puts 'Сделайте выбор:
    1. Пропустить
    2. Добавить карту
    3. Открыть карты'
    gets.chomp.strip
  end

  def print_winner(player)
    puts "победил #{player.name}!"
  end

  def print_draw
    puts 'Ничья!'
  end

  def current_state(show, dealer, player)
    system "clear" unless show
    puts "Деньги дилера #{dealer.money}$, карты дилера:"
    dealer.cards.size.times { print "#{CLOSED_CARDS} " } unless show
    dealer.cards.each { |card| print "#{card[:card]} " } if show
    puts ''
    puts "Очки дилера #{dealer.points}" if show
    puts "Ваши деньги #{player.money}$, Ваши карты:"
    player.cards.each { |card| print "#{card[:card]} " }
    puts ''
    puts "Ваши очки = #{player.points}"
  end
end

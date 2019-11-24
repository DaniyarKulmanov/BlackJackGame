module Interface
  module_function

  def ask_name
    puts 'Как Вас зовут?'
    gets.chomp
  end

  def ask_gender
    puts 'Укажите Ваш пол, введите М или Ж'
    gets.chomp.strip
  end

end

This is Black Jack game
UI:

1. Welcome UI
2. Game UI 
2.1 Пропустить
2.2 Добавить карту
2.3 Открыть карты
3. Game over UI

Game data:
@user_name
@dealer_money
@user_money
@card_deck - 52 cards

Round_data:
@round_money
@dealer_points
@user_points

Round_steps:
1. user 
2. dealer
3. open cards
load './user.rb'
load './game.rb'
user = User.new 'sss', 'Ж'
deck = Deck.new
2.times { player.cards.push deck.cards.sample }
deck.cards.each_with_index { |value, index| puts "#{index} - #{value}" }

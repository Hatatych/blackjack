# Game interface, menus etc
class Interface
  NO_SUCH_CHOICE = 'Нет такого выбора!'.freeze
  BYE = 'Всего доброго :)'.freeze
  BUSTED = 'Не хватает денег на ставку!'.freeze
  DEALER_BUSTED = 'Ты разорил этого казино!'.freeze
  FULL_HAND = 'Ты не можешь взять больше карт!'.freeze

  def self.ask_name
    puts 'Как тебя зовут?'
    gets.chomp.capitalize
  end

  def recieve_choice
    puts
    puts 'Ваш выбор:'
    gets.to_i
  end

  def main_menu(player)
    puts "Добро пожаловать, #{player.name}!"
    player_with_balance(player)
    puts
    puts 'Что будем делать?'
    puts '1. Начать игру!'
    puts '2. Выйти'
  end

  def decision_menu(player, dealer)
    print_players(player, dealer)
    puts 'Что будем делать?'
    puts '1. Взять карту'
    puts '2. Пропустить ход'
    puts '3. Открыть карты'
  end

  def show_results(player, dealer, winner = nil)
    print_players(player, dealer)
    if winner.nil?
      puts 'Ничья!'
      return
    else
      puts "Победил #{winner.name}!"
    end
  end

  def reset_menu(player)
    player_with_balance(player)
    puts 'Сыграем еще раз?'
    puts '1. Да'
    puts '2. Нет'
  end

  def bye
    puts BYE
  end

  def full_hand
    raise FULL_HAND
  end

  def busted
    raise BUSTED
  end

  def invalid_choice
    raise NO_SUCH_CHOICE
  end

  def continue?
    case recieve_choice
    when 1 then true
    when 2 then false
    else invalid_choice
    end
  end

  def show_error(message)
    puts
    puts "Ошибка! #{message}"
    puts
  end

  private

  def print_players(player, dealer)
    puts
    puts player
    puts dealer
    puts
  end

  def player_with_balance(player)
    puts "#{player.name}, у тебя #{player.balance}"
    puts
  end
end

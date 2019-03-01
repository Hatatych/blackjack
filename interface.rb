# Game interface, menus etc
class Interface
  NO_SUCH_CHOICE = 'Нет такого выбора!'.freeze
  BYE = 'Всего доброго :)'.freeze
  BUSTED = 'Не хватает денег на ставку!'.freeze
  DEALER_BUSTED = 'Ты разорил этого казино!'.freeze

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def recieve_choice
    puts
    puts 'Ваш выбор:'
    gets.to_i
  end

  def main_menu
    puts "Добро пожаловать, #{@player.name}!"
    player_with_balance
    puts
    puts 'Что будем делать?'
    puts '1. Начать игру!'
    puts '2. Выйти'
  end

  def decision_menu
    print_players
    puts 'Что будем делать?'
    puts '1. Взять карту'
    puts '2. Пропустить ход'
    puts '3. Открыть карты'
  end

  def show_results(player = nil)
    print_players
    if player.nil?
      puts 'Ничья!'
      return
    else
      puts "Победил #{player.name}!"
    end
  end

  def reset_menu
    player_with_balance
    puts 'Сыграем еще раз?'
    puts '1. Да'
    puts '2. Нет'
  end

  def bye
    puts BYE
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

  def print_players
    puts
    puts @player
    puts @dealer
    puts
  end

  def player_with_balance
    puts "#{@player.name}, у тебя #{@player.balance}"
    puts
  end
end

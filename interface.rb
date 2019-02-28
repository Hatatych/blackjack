# Game interface, menus etc
class Interface
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
    puts InterfaceMessages::BYE
  end

  def invalid_choice
    raise InterfaceMessages::NO_SUCH_CHOICE
  end

  private

  def print_players
    puts @player
    puts @dealer
    puts
  end

  def player_with_balance
    puts "#{@player.name}, у тебя #{@player.balance}"
    puts
  end
end

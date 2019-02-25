require_relative './deck.rb'
require_relative './player.rb'
require_relative './dealer.rb'

# That class handles game logic
class Game
  NO_SUCH_CHOICE = 'Варианта с таким номером нет'.freeze
  attr_reader :player, :dealer, :deck

  def initialize(player_name)
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = 0
  end

  def init_deal
    @player.bet
    @dealer.bet
    @bank += 20
    2.times do
      @player.take_card @deck
      @dealer.take_card @deck
    end
  end

  def decide
    decision = gets.to_i

    case decision
    when 1 then skip_turn
    when 2 then @player.take_card @deck
    when 3 then open_cards
    else raise NO_SUCH_CHOICE
    end
  end

  def ai_decide
    if @dealer.points < 17 && @dealer.can_take_card?
      @dealer.take_card @deck
    else
      skip_turn
    end
  end

  def skip_turn
    "#{@name} пропустил ход"
  end

  def open_cards
    @dealer.opened_cards = true
    if @dealer.points > @player.points
      'В игре победил дилер!'
    else
      'Вы выиграли эту игру!'
    end
  end
end

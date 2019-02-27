require_relative './player.rb'
require_relative './dealer.rb'
require_relative './round.rb'
require_relative './deck.rb'
require_relative './interface.rb'
require_relative './interface_messages.rb'

# Base game class
class Game
  BYE = 'Всего доброго :)'.freeze

  def initialize(player_name = 'Anonymous')
    @game_running = false
    @player = Player.new player_name
    @dealer = Dealer.new
    @bank = 0
    @deck = Deck.new
    @interface = Interface.new @player, @dealer
    run
  end

  def run
    @interface.main_menu
    case @interface.recieve_choice
    when 1 then start_round
    when 2 then abort BYE
    else raise InterfaceMessages::NO_SUCH_CHOICE
    end
  end

  def start_round
    init_deal
    @game_running = true
    decide
    ai_decide
    final_scoring
  end

  def init_deal
    @dealer.opened_cards = false
    @player.bet
    @dealer.bet
    @bank += GameRules::DEFAULT_BET * 2
    2.times do
      @player.take_card @deck
      @dealer.take_card @deck
    end
  end

  def ai_decide
    @dealer.take_card @deck if @dealer.score < GameRules::DEALER_DUMMY_SCORE && @game_running
  end

  def decide
    @interface.decision_menu
    case @interface.recieve_choice
    when 1 then @player.take_card @deck
    when 2 then return
    when 3 then end_round
    else raise InterfaceMessages::NO_SUCH_CHOICE
    end
  end

  def end_round
    @dealer.opened_cards = true
    final_scoring
    @game_running = false
  end

  def final_scoring
    @dealer.opened_cards = true
    blackjack = { player: false, dealer: false }
    blackjack[:player] = true if @player.score >= GameRules::BLACKJACK
    blackjack[:dealer] = true if @dealer.score >= GameRules::BLACKJACK

    if !blackjack[:player] && !blackjack[:dealer]
      if @player.score > @dealer.score && @game_running
        @interface.show_results @player
        @player.jackpot @bank
      elsif @player.score < @dealer.score && @game_running
        @interface.show_results @dealer
        @dealer.jackpot @bank
      elsif @game_running
        @interface.show_results
        @dealer.jackpot @bank / 2
        @player.jackpot @bank / 2
      end
    elsif blackjack[:player] && !blackjack[:dealer] || !blackjack[:player] && blackjack[:dealer]
      if @player.score > @dealer.score
        @interface.show_results @player
        @player.jackpot @bank
      else
        @interface.show_results @dealer
        @dealer.jackpot @bank
      end
    else
      @interface.show_results
    end
    @game_running = false
    @interface.reset_menu
    case @interface.recieve_choice
    when 1 then flush_and_discard
    when 2 then abort BYE
    end
  end

  def flush_and_discard
    @player.discard
    @dealer.discard
    @bank = 0
    @deck = Deck.new
    start_round
  end
end

require_relative './player.rb'
require_relative './dealer.rb'
require_relative './round.rb'
require_relative './deck.rb'
require_relative './interface.rb'
require_relative './interface_messages.rb'
require_relative './bank.rb'

# Base game class
class Game
  def initialize(player_name = 'Anonymous')
    @game_running = false
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @bank = Bank.new
    @deck = Deck.new
    @interface = Interface.new(@player, @dealer)
    run
  end

  def run
    @interface.main_menu
    case @interface.recieve_choice
    when 1 then start_round
    when 2 then exit_from_game
    else @interface.invalid_choice
    end
  end

  def start_round
    init_deal
    @game_running = true
    loop do
      break if decide.nil?

      ai_decide
      break if @player.full_hand? && @dealer.full_hand?
    end
    final_scoring
  end

  def init_deal
    @dealer.opened_cards = false
    @bank.bet(@player)
    @bank.bet(@dealer)
    2.times do
      @player.take_card(@deck)
      @dealer.take_card(@deck)
    end
  end

  def ai_decide
    @dealer.take_card(@deck) if @dealer.score < GameRules::DEALER_DUMMY_SCORE && @game_running && !@dealer.full_hand?
  end

  def decide
    @interface.decision_menu
    case @interface.recieve_choice
    when 1 then @player.take_card(@deck)
    when 2 then return 1
    when 3 then end_round
    else @interface.invalid_choice
    end
  end

  def end_round
    @dealer.opened_cards = true
    final_scoring
    @game_running = false
    nil
  end

  def final_scoring
    @dealer.opened_cards = true
    winner = who_won?
    if winner.nil?
      @interface.show_results
      @bank.refund(@player, @dealer)
    else
      @interface.show_results(winner)
      @bank.reward(winner)
    end
    @game_running = false
    @interface.reset_menu
    case @interface.recieve_choice
    when 1 then flush_and_discard
    when 2 then exit_from_game
    end
  end

  def flush_and_discard
    @player.discard
    @dealer.discard
    @bank = Bank.new
    @deck = Deck.new
    start_round
  end

  def exit_from_game
    @interface.bye
    exit
  end

  def who_won?
    blackjack = { player: false, dealer: false }
    blackjack[:player] = true if @player.score >= GameRules::BLACKJACK
    blackjack[:dealer] = true if @dealer.score >= GameRules::BLACKJACK

    if !blackjack[:player] && !blackjack[:dealer]
      if @player.score > @dealer.score && @game_running
        @player
      elsif @player.score < @dealer.score && @game_running
        @dealer
      elsif @game_running
        nil
      end
    elsif blackjack[:player] && !blackjack[:dealer] || !blackjack[:player] && blackjack[:dealer]
      if @player.score > @dealer.score
        @dealer
      else
        @player
      end
    end
  end

  def refund
    @player.jackpot(@bank / 2)
    @dealer.jackpot(@bank / 2)
  end
end

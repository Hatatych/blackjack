require_relative './player.rb'
require_relative './dealer.rb'
require_relative './round.rb'
require_relative './deck.rb'
require_relative './interface.rb'
require_relative './bank.rb'

# Base game class
class Game
  PLAYER_DECISIONS = %i[take_card skip open].freeze

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
  rescue RuntimeError => e
    @interface.show_error(e.message)
    retry
  end

  def start_round
    init_deal
    @game_running = true
    loop do
      break if decide == :open

      ai_decide
      break if @player.full_hand? && @dealer.full_hand?
    end
    final_scoring
    @interface.reset_menu
    @interface.continue? ? flush_and_discard : exit_from_game
  end

  def init_deal
    raise Interface::BUSTED if @player.busted?
    raise Interface::DEALER_BUSTED if @dealer.busted?

    @dealer.opened_cards = false
    @bank.bet(@player)
    @bank.bet(@dealer)
    2.times do
      @player.take_card(@deck)
      @dealer.take_card(@deck)
    end
  rescue RuntimeError => e
    @interface.show_error(e.message)
    exit_from_game
  end

  def ai_decide
    @dealer.take_card(@deck) if @dealer.can_take_card? && @game_running
  end

  def decide
    @interface.decision_menu
    case PLAYER_DECISIONS[@interface.recieve_choice - 1]
    when :take_card then @player.take_card(@deck)
    when :skip then return
    when :open
      end_round
      return :open
    else @interface.invalid_choice
    end
  rescue RuntimeError => e
    @interface.show_error(e.message)
    retry
  end

  def end_round
    @dealer.opened_cards = true
    final_scoring
    @game_running = false
  end

  def final_scoring
    @dealer.opened_cards = true
    winner = define_winner
    if winner.nil?
      @interface.show_results
      @bank.refund(@player, @dealer)
    else
      @interface.show_results(winner)
      @bank.reward(winner)
    end
    @game_running = false
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

  def define_winner
    return if @player.overage? && @dealer.overage?
    return if @player.score == @dealer.score
    return @dealer if @player.overage?
    return @player if @dealer.overage?

    [@player, @dealer].max_by(&:score)
  end
end

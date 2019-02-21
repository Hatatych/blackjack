# Class that determines a player (parent class for person and AI)
class Player
  NO_SUCH_CHOICE = 'Варианта с таким номером нет'.freeze

  attr_reader :cards

  def initialize(game, name = 'Dealer')
    @game = game
    @name = name
    @balance = 100
    @cards = []
    2.times { @cards << @game.pile.take_card }
  end

  def decide(decision)
    case decision
    when 1 then skip
    when 2 then add_card
    when 3 then open_cards
    else raise NO_SUCH_CHOICE
    end
  end

  def discard
    @cards.each { |card| @game.pile.discard(card) }
  end

  def to_s
    "#{@name}: #{print_cards}Сумма очков: #{count_points}"
  end

  private

  def print_cards
    output = ''
    @cards.each { |card| output += card.to_s + ' ' }
    output
  end

  def count_points
    total_points = 0
    @cards.each { |card| total_points += card.weight }
    total_points
  end

  def skip
    @game.skip_turn
  end

  def add_card
    @cards << @game.pile.take_card
  end

  def open_cards
    @game.open_cards
  end
end

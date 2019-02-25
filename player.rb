require_relative './hand.rb'
require_relative './card.rb'

# Class that determines a player itself
class Player
  def initialize(name = 'Dealer')
    @name = name
    @hand = Hand.new
    @balance = 100
  end

  def to_s
    "#{@name}: #{@hand.print_cards} Сумма очков: #{@hand.score}"
  end

  def points
    @hand.score
  end

  def can_take_card?
    return false if @hand.cards.length == 3

    true
  end

  def take_card(deck)
    @hand << deck.take_card
  end

  def bet
    @balance -= 10
  end
end

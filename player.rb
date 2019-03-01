require_relative './hand.rb'

# This class handle player's logic
class Player
  attr_reader :name, :balance

  def initialize(name = 'Dealer')
    @name = name
    @balance = GameRules::INIT_MONEY
    @hand = Hand.new
  end

  def take_card(deck)
    @hand << deck.take_card
  end

  def discard
    @hand.discard
  end

  def to_s
    "#{@name}: #{@hand.print_cards} Сумма очков: #{@hand.score}"
  end

  def score
    @hand.score
  end

  def busted?
    @balance < GameRules::DEFAULT_BET
  end

  def withdraw(amount = GameRules::DEFAULT_BET)
    @balance -= amount
  end

  def add_money(amount = GameRules::DEFAULT_BET)
    @balance += amount
  end

  def overage?
    score >= GameRules::BLACKJACK
  end

  def full_hand?
    @hand.cards.length == 3
  end

  def can_take_card?
    !full_hand?
  end
end

require_relative './game_rules.rb'

# Class that stores player's cards and counts points
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def <<(card)
    @cards << card
  end

  def score
    points = 0
    aces = 0
    @cards.each do |card|
      aces += 1 if card.ace?
      points += Card::WEIGHTS[card.value]
    end

    (1..aces).each do
      points += GameRules::ACE_CORRECTION if points + GameRules::ACE_CORRECTION < GameRules::BLACKJACK
    end

    points
  end

  def print_cards
    @cards.join(' ')
  end

  def discard
    @cards = []
  end
end

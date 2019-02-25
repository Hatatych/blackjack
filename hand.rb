# Class that stores player's cards and counts points
class Hand
  attr_reader :cards

  WEIGHTS = {
    two: 2, three: 3, four: 4, five: 5, six: 6,
    seven: 7, eight: 8, nine: 9, ten: 10,
    jack: 10, queen: 10, king: 10, ace: 1
  }.freeze

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
      points += WEIGHTS[card.value]
    end

    (1..aces).each do
      points += 10 if points + 10 < 21
    end

    points
  end

  def print_cards
    @cards.join(' ')
  end
end

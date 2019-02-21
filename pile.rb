# Class that determines a game pile that contains cards
class Pile
  LEARS = %i[spades hearts diamonds clubs].freeze
  VALUES = %i[
    ace two three four five
    six seven eight nine ten
    jack queen king
  ].freeze

  attr_reader :cards

  def initialize
    @cards = []
    @discard = []

    LEARS.each do |lear|
      VALUES.each do |value|
        @cards << Card.new(value, lear)
      end
    end

    @cards.shuffle!
  end

  def take_card
    card_to_give = @cards.first
    @cards.shift
    card_to_give
  end

  def discard(card)
    @discard << card
  end
end

require_relative './card.rb'

# Class that determines a game pile that contains cards
class Deck
  attr_reader :cards

  def initialize
    @cards = []

    Card::LEARS.each_key do |lear|
      Card::VALUES.each_key do |value|
        @cards << Card.new(value, lear)
      end
    end

    @cards.shuffle!
  end

  def take_card
    @cards.shift
  end
end
